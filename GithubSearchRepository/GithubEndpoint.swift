//
//  GithubAPI.swift
//  SwiftBookSample
//
//  Created by yusei-nishiyama on 9/13/15.
//  Copyright © 2015 yusei-nishiyama. All rights reserved.
//

import Foundation

struct PaginatedResponse<Item: JSONDecodable>: ResponseType {
    let totalCount: Int
    let links: Links
    let items: [Item]

    init(JSON: AnyObject, URLResponse: NSHTTPURLResponse) throws {
        guard let totalCount = JSON["total_count"] as? Int else {
            throw APIClientError.InvalidDataType(JSON)
        }
        self.totalCount = totalCount

        self.links = Links(HTTPURLResponse: URLResponse)

        guard let itemDictionaries =
            JSON["items"] as? Array<[String : AnyObject]> else
        {
            throw APIClientError.InvalidDataType(JSON)
        }
        var items: [Item] = []
        for itemDictionary in itemDictionaries {
            do {
                let item = try Item(JSON: itemDictionary)
                items.append(item)
            } catch {
                throw APIClientError.JSONMappingError(itemDictionary)
            }
        }
        self.items = items
    }
}

protocol GithubEndpoint : Endpoint {}

extension GithubEndpoint {
    var baseURL: NSURL { return NSURL(string: "https://api.github.com")! }
}

struct Search {
    struct Repository : GithubEndpoint {
        typealias Response = Repositories

        let searchKeyword: String
        init(searchKeyword: String) { self.searchKeyword = searchKeyword }
        var parameters: [String : AnyObject] { return ["q" : searchKeyword]}
        var path: String { return "search/repositories" }
        var method: HTTPMethod { return .GET }
    }
}

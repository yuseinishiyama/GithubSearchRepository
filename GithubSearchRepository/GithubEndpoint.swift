//
//  GithubAPI.swift
//  SwiftBookSample
//
//  Created by yusei-nishiyama on 9/13/15.
//  Copyright © 2015 yusei-nishiyama. All rights reserved.
//

import Foundation

protocol Pageable {
    typealias ItemType: JSONDecodable
    var totalCount: Int { get }
    var links: Links { get }
    var items: [ItemType] { get }
    init(totalCount: Int, items: [ItemType], links: Links)
}

protocol GithubEndpoint : Endpoint {}

extension GithubEndpoint {
    var baseURL: NSURL { return NSURL(string: "https://api.github.com")! }
}

extension GithubEndpoint where Self.ResponseType: Pageable {
    func parseResponse(data: NSData, URLResponse: NSURLResponse) throws -> ResponseType {
        do {
            guard let dic = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String : AnyObject] else {
                throw APIClientError.InvalidDataType(data)
            }

            guard let itemDictionaries = dic["items"] as? Array<[String : AnyObject]> else {
                throw APIClientError.InvalidDataType(data)
            }

            var items: [ResponseType.ItemType] = []
            for itemDictionary in itemDictionaries {
                do {
                    let item = try ResponseType.ItemType(JSON: itemDictionary)
                    items.append(item)
                } catch {
                    throw APIClientError.JSONMappingError(itemDictionary)
                }
            }

            let links = Links(HTTPURLResponse: URLResponse as! NSHTTPURLResponse)

            guard let totalCount = dic["total_count"] as? Int else {
                throw APIClientError.InvalidDataType(data)
            }

            return ResponseType(totalCount: totalCount, items: items, links: links)
        } catch {
            throw APIClientError.JSONSerializationError(error)
        }
    }
}

struct Search {
    struct Repository : GithubEndpoint {
        typealias ResponseType = Repositories

        let searchKeyword: String
        init(searchKeyword: String) { self.searchKeyword = searchKeyword }
        var parameters: [String : AnyObject] { return ["q" : searchKeyword]}
        var path: String { return "search/repositories" }
        var method: HTTPMethod { return .GET }
    }
}

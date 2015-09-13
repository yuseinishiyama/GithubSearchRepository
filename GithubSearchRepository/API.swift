//
//  API.swift
//  SwiftBookSample
//
//  Created by yusei-nishiyama on 9/13/15.
//  Copyright © 2015 yusei-nishiyama. All rights reserved.
//

import Foundation

protocol API {
    typealias ResponseType

    var baseURL: NSURL { get }
    var parameters: [String : AnyObject] { get }
    var path: String { get }
    var method: HTTPMethod { get }
    func parseResponse(data: NSData, URLResponse: NSURLResponse) throws -> ResponseType
}

protocol JSONDecodable {
    init(JSON: [String : AnyObject]) throws
}

extension API where Self.ResponseType: JSONDecodable {
    func parseResponse(data: NSData, URLResponse: NSURLResponse) throws -> ResponseType {
        do {
            guard let dictionary = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String : AnyObject] else {
                throw APIClientError.InvalidDataType(data)
            }

            do {
                return try ResponseType(JSON: dictionary)
            } catch {
                throw error
            }
        } catch {
            throw APIClientError.JSONSerializationError(error)
        }
    }
}

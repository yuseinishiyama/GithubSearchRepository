//
//  API.swift
//  SwiftBookSample
//
//  Created by yusei-nishiyama on 9/13/15.
//  Copyright © 2015 yusei-nishiyama. All rights reserved.
//

import Foundation

protocol Endpoint {
    typealias Response

    var baseURL: NSURL { get }
    var parameters: [String : AnyObject] { get }
    var path: String { get }
    var method: HTTPMethod { get }
    func parseResponse(data: NSData, URLResponse: NSURLResponse) throws -> Response
}

protocol JSONDecodable {
    init(JSON: [String : AnyObject]) throws
}

extension Endpoint where Self.Response: JSONDecodable {
    func parseResponse(data: NSData, URLResponse: NSURLResponse) throws -> Response {
        do {
            guard let dictionary = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String : AnyObject] else {
                throw APIClientError.InvalidDataType(data)
            }

            do {
                return try Response(JSON: dictionary)
            } catch {
                throw error
            }
        } catch {
            throw APIClientError.JSONSerializationError(error)
        }
    }
}

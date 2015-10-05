//
//  APIClient.swift
//  SwiftBookSample
//
//  Created by yusei-nishiyama on 9/13/15.
//  Copyright © 2015 yusei-nishiyama. All rights reserved.
//

import Foundation

struct APIClient {
    static func sendRequest<T: Endpoint>(
        endpoint: T,
        completion: Result<T.Response, APIClientError> -> Void)
    {
        let url = endpoint.baseURL.URLByAppendingPathComponent(endpoint.path)
        guard let components = NSURLComponents(URL: url,
                           resolvingAgainstBaseURL: false) else
        {
            return completion(.Failure(APIClientError.URLCompositionError))
        }

        let request: NSMutableURLRequest
        switch endpoint.method {
        case .GET:
            let queryItems = endpoint.parameters.map {
                key, value -> NSURLQueryItem in
                return NSURLQueryItem(name: String(key),
                                     value: String(value))
            }
            components.queryItems = queryItems
            guard let urlWithQuery = components.URL else {
                return completion(.Failure(APIClientError.URLCompositionError))
            }
            request = NSMutableURLRequest(URL: urlWithQuery)
            request.setValue("application/x-www-form-urlencoded",
                             forHTTPHeaderField: "Content-Type")
        }

        request.HTTPMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> () in
            if let data = data, let response = response {
                do {
                    let response = try endpoint.parseResponse(data, URLResponse: response)
                    return completion(.Success(response))
                } catch {
                    return completion(.Failure(error as! APIClientError))
                }
            } else {
                return completion(.Failure(APIClientError.NoData))
            }
        }
        task.resume()
    }
}

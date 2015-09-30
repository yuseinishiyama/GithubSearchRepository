//
//  APIClient.swift
//  SwiftBookSample
//
//  Created by yusei-nishiyama on 9/13/15.
//  Copyright © 2015 yusei-nishiyama. All rights reserved.
//

import Foundation

struct APIClient {
    static func sendRequest<T: API>(API: T, completion: Result<T.ResponseType, APIClientError> -> Void) {
        let url = API.baseURL.URLByAppendingPathComponent(API.path)
        guard let components = NSURLComponents(URL: url, resolvingAgainstBaseURL: false) else {
            return completion(.Failure(APIClientError.URLCompositionError))
        }

        let request: NSMutableURLRequest
        switch API.method {
        case .GET:
            components.percentEncodedQuery = API.parameters.queryString()
            guard let urlWithQuery = components.URL else {
                return completion(.Failure(APIClientError.URLCompositionError))
            }
            request = NSMutableURLRequest(URL: urlWithQuery)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }

        request.HTTPMethod = API.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> () in
            if let data = data, let response = response {
                do {
                    let response = try API.parseResponse(data, URLResponse: response)
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

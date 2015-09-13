//
//  User.swift
//  SwiftBookSample
//
//  Created by yusei-nishiyama on 9/13/15.
//  Copyright © 2015 yusei-nishiyama. All rights reserved.
//

import Foundation

struct User : JSONDecodable {
    let id: Int
    let login: String

    init(JSON: [String : AnyObject]) throws {
        if let id = JSON["id"] as? Int,
            let login = JSON["login"] as? String {
                self.id = id
                self.login = login
        } else {
            throw APIClientError.JSONMappingError(JSON)
        }
    }
}

//
//  Repository.swift
//  SwiftBookSample
//
//  Created by yusei-nishiyama on 9/13/15.
//  Copyright © 2015 yusei-nishiyama. All rights reserved.
//

import Foundation

struct Repository : JSONDecodable {
    let id: Int
    let name: String
    let owner: User
    let fullName: String

    init(JSON: [String : AnyObject]) throws {
        if let id = JSON["id"] as? Int,
            let name = JSON["name"] as? String,
            let fullName = JSON["full_name"] as? String {
                self.name = name
                self.id = id
                self.fullName = fullName
        } else {
            throw APIClientError.JSONMappingError(JSON)
        }

        if let owner = JSON["owner"] as? [String : AnyObject] {
            do {
                self.owner = try User(JSON: owner)
            } catch {
                throw error
            }
        } else {
            throw APIClientError.JSONMappingError(JSON)
        }
    }
}

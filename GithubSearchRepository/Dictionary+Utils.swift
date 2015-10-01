//
//  Dictionary+Utils.swift
//  SwiftBookSample
//
//  Created by yusei-nishiyama on 9/13/15.
//  Copyright © 2015 yusei-nishiyama. All rights reserved.
//

import Foundation

extension Dictionary {
    func queryItems() -> [NSURLQueryItem] {
        return self.map { key, value -> NSURLQueryItem in
            return NSURLQueryItem(name: String(key),
                                 value: String(value))
        }
    }
}

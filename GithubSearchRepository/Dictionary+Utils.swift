//
//  Dictionary+Utils.swift
//  SwiftBookSample
//
//  Created by yusei-nishiyama on 9/13/15.
//  Copyright © 2015 yusei-nishiyama. All rights reserved.
//

import Foundation

extension Dictionary {
    func queryString() -> String {
        let keyValuePairs = self.map { key, value -> String in
            let stringValue = (value as? String) ?? "\(value)"
            return "\(key)=\(stringValue)"
        }

        return keyValuePairs.joinWithSeparator("&")
    }
}

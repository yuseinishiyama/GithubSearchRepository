//
//  Links.swift
//  SwiftBookSample
//
//  Created by yusei-nishiyama on 9/13/15.
//  Copyright © 2015 yusei-nishiyama. All rights reserved.
//

import Foundation


struct Links {
    let first: NSURL?
    let prev: NSURL?
    let next: NSURL?
    let last: NSURL?

    init(HTTPURLResponse: NSHTTPURLResponse) {
        let links = HTTPURLResponse.allHeaderFields["Links"]
        first = NSURL()
        prev = NSURL()
        next = NSURL()
        last = NSURL()
    }
}

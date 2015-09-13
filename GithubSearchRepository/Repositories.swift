//
//  Repositories.swift
//  SwiftBookSample
//
//  Created by yusei-nishiyama on 9/13/15.
//  Copyright © 2015 yusei-nishiyama. All rights reserved.
//

import Foundation

struct Repositories : Pageable {
    var totalCount: Int
    var items: [Repository]
    var links: Links

    init(totalCount: Int, items: [Repository], links: Links) {
        self.totalCount = totalCount
        self.items = items
        self.links = links
    }
}

//
//  Result.swift
//  SwiftBookSample
//
//  Created by yusei-nishiyama on 9/13/15.
//  Copyright © 2015 yusei-nishiyama. All rights reserved.
//

import Foundation

public enum Result<T, Error: ErrorType> {
    case Success(T)
    case Failure(Error)

    public init(value: T) {
        self = .Success(value)
    }

    public init(error: Error) {
        self = .Failure(error)
    }
}

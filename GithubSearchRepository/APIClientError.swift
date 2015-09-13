//
//  APIClientError.swift
//  SwiftBookSample
//
//  Created by yusei-nishiyama on 9/13/15.
//  Copyright © 2015 yusei-nishiyama. All rights reserved.
//

import Foundation

enum APIClientError : ErrorType {
    case URLCompositionError
    case JSONSerializationError(ErrorType)
    case JSONMappingError([String : AnyObject])
    case InvalidDataType(AnyObject)
    case NoData
}

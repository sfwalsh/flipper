//
//  NetworkResult.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

enum NetworkResult<T, ErrorType> {
    case success(value: T)
    case failure(error: ErrorType)
}

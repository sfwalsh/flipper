//
//  MenuFetchError.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

enum MenuFetchError: Error {
    case notFound, jsonDecoding, requestError
    case network(description: String)
}

extension MenuFetchError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .notFound:
            return NSLocalizedString("MENU_FETCH_ERROR_REQUEST_ERROR", comment: "")
        case .jsonDecoding:
            return NSLocalizedString("MENU_FETCH_ERROR_UNEXPECTED_RESPONSE", comment: "")
        case .requestError:
            return NSLocalizedString("MENU_FETCH_ERROR_GENERIC", comment: "")
        case .network(let description):
            return description
        }
    }
}


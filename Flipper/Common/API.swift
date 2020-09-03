//
//  API.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

enum API {
    
    private enum URLScheme: String {
        case https, http
    }
    
    private enum HTTPMethod: String {
        case GET, PUT, UPDATE, DELETE
    }
    
    private static let host: String = "menus.flipdish.co"
    
    static func fetchMenuRequest() -> URLRequest? {
        var components = URLComponents()
        components.host = host
        components.scheme = URLScheme.https.rawValue
        
        // NOTE: the path has been hardcoded
        components.path = "/prod/16798/e6220da2-c34a-4ea2-bb51-a3e190fc5f08.json"
        
        guard let url = components.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.GET.rawValue
        
        return urlRequest
    }
}

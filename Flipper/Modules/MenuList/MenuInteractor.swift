//
//  MenuInteractor.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

final class MenuInteractor {

}

// MARK: MenuInteractorRepresentable Implementation

extension MenuInteractor: MenuInteractorRepresentable {
    
    func fetchMenu(completion: @escaping ((NetworkResult<Menu, MenuFetchError>) -> Void)) {
        guard let request = API.fetchMenuRequest() else {
            completion(.failure(error: .requestError))
            return
        }
        
        URLSession.shared.dataTask(with: request,
                                   completionHandler: { [weak self] (data, response, error) in
                                    if let error = error {
                                        completion(.failure(error: .network(description: error.localizedDescription)))
                                        return
                                    }
                                    
                                    guard let data = data,
                                        let menu = self?.parseMenuResponseData(data: data) else {
                                        completion(.failure(error: .jsonDecoding))
                                        return
                                    }
                                    completion(.success(value: menu))
        }).resume()
    }
}

// MARK: Private helper functions

extension MenuInteractor {
    
    private func parseMenuResponseData(data: Data) -> Menu? {
        return try? JSONDecoder().decode(Menu.self, from: data)
    }
}

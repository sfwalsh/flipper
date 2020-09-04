//
//  MockMenuInteractor.swift
//  FlipperTests
//
//  Created by Stephen Walsh on 04/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

@testable import Flipper

final class MockMenuInteractor: MenuInteractorRepresentable {
    
    struct DidCall {
        var fetchMenu: Bool = false
    }
    
    var didCall: DidCall = DidCall()
    
    private let result: NetworkResult<Menu, MenuFetchError>
    
    init(withResult result: NetworkResult<Menu, MenuFetchError>) {
        self.result = result
    }
    
    func fetchMenu(completion: @escaping ((NetworkResult<Menu, MenuFetchError>) -> Void)) {
        didCall.fetchMenu = true
        completion(result)
    }
}

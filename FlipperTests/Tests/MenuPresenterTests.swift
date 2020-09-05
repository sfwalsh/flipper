//
//  FlipperTests.swift
//  FlipperTests
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import XCTest
@testable import Flipper

class MenuPresenterTests: XCTestCase {
    
    // Okay to explicitly unwrap optionals here as it's in the tests
    
    var sut: MenuPresenter!
    var view: MockMenuView!
    var interactor: MockMenuInteractor!
    var router: MockMenuRouter!
    
    private func createNewSetup(withInteractor interactor: MockMenuInteractor) {
        view = MockMenuView()
        router = MockMenuRouter()
        self.interactor = interactor
        sut = MenuPresenter(interactor: interactor, router: router)
        
        sut.attachView(view: view)
        sut.viewDidLoad()
    }

    override func tearDown() {
        sut = nil
        view = nil
        interactor = nil
        router = nil
        
        super.setUp()
    }
    
    func testSetupSuccess() {
        let result: NetworkResult<Menu, MenuFetchError> = .success(value: Menu.createDummy())
        createNewSetup(withInteractor: MockMenuInteractor(withResult: result))
        
        XCTAssert(view.didUpdate.title(toValue: NSLocalizedString("FLIPPER_TITLE", comment: "")), "title has been set")
        XCTAssert(view.didCall.setupSubviews, "subviews were setup")
    }
    
    func testMenuFetchSuccess() {
        let result: NetworkResult<Menu, MenuFetchError> = .success(value: Menu.createDummy())
        createNewSetup(withInteractor: MockMenuInteractor(withResult: result))
        
        XCTAssert(view.didCall.showActivityIndicator, "activity indicator was shown")
        XCTAssert(interactor.didCall.fetchMenu, "fetch function was called")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssert(self.view.didCall.hideActivityIndicator, "activity indicator was hidden")
            XCTAssert(self.view.didCall.reload, "view was reloaded")
        }
    }
    
    func testMenuFetchFailure_requestError() {
        let result: NetworkResult<Menu, MenuFetchError> = .failure(error: .requestError)
        createNewSetup(withInteractor: MockMenuInteractor(withResult: result))
        
        XCTAssert(view.didCall.showActivityIndicator, "activity indicator was shown")
        XCTAssert(interactor.didCall.fetchMenu, "fetch function was called")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssert(self.view.didCall.hideActivityIndicator, "activity indicator was hidden")
            XCTAssertFalse(self.view.didCall.reload, "view was not reloaded")
            XCTAssert(self.router.didUpdate.alertMessage(to: MenuFetchError.requestError.localizedDescription), "alert was presented with relevant error")
        }
    }
    
    func testMenuFetchFailure_jsonDecoding() {
        let result: NetworkResult<Menu, MenuFetchError> = .failure(error: .jsonDecoding)
        createNewSetup(withInteractor: MockMenuInteractor(withResult: result))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssert(self.router.didUpdate.alertMessage(to: MenuFetchError.jsonDecoding.localizedDescription), "alert was presented with relevant error")
        }
    }
    
    func testMenuFetchFailure_notFound() {
        let result: NetworkResult<Menu, MenuFetchError> = .failure(error: .notFound)
        createNewSetup(withInteractor: MockMenuInteractor(withResult: result))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssert(self.router.didUpdate.alertMessage(to: MenuFetchError.notFound.localizedDescription), "alert was presented with relevant error")
        }
    }
    
    func testMenuFetchFailure_networkError() {
        let networkError = MenuFetchError.network(description: "404 not found")
        let result: NetworkResult<Menu, MenuFetchError> = .failure(error: networkError)
        createNewSetup(withInteractor: MockMenuInteractor(withResult: result))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssert(self.router.didUpdate.alertMessage(to: networkError.localizedDescription), "alert was presented with relevant error")
        }
    }
    
    func testSelectItem() {
        let result: NetworkResult<Menu, MenuFetchError> = .success(value: Menu.createDummy())
        createNewSetup(withInteractor: MockMenuInteractor(withResult: result))
        
        sut.didSelectItem(atIndexPath: IndexPath(item: 0, section: 0))
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssert(self.router.didCall.routeToDetail, "sut alerted router to navigate to detail view")
        }
    }
}

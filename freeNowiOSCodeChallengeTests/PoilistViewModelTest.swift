//
//  PoilistViewModelTest.swift
//  freeNowiOSCodeChallengeTests
//
//  Created by kjoe on 11/16/20.
//

import XCTest
@testable import freeNowiOSCodeChallenge
class PoilistViewModelTest: XCTestCase {
    var sut: PoiListViewModel!
    var service: MockPolistService!
    override func setUpWithError() throws {
    service  = MockPolistService()
       sut = PoiListViewModel(service: service)
    }

    override func tearDownWithError() throws {
        service = nil
        sut = nil
    }

    func test_taskIsNotNilWhenLoadData(){
        sut.loadData()
        XCTAssertNotNil(sut.task)
    }

}

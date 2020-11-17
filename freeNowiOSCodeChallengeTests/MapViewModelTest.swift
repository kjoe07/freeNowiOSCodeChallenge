//
//  MapViewModelTest.swift
//  freeNowiOSCodeChallengeTests
//
//  Created by kjoe on 11/17/20.
//

import XCTest
@testable import freeNowiOSCodeChallenge
class MapViewModelTest: XCTestCase {

    var sut: MapViewModel!
    var service: PoilistService!
    override func setUpWithError() throws {
        service = MockPolistService()
        sut = MapViewModel(service: service)
    }

    override func tearDownWithError() throws {
        service = nil
        sut = nil
    }

    func test_MarkerViewModelCountEqualsToListCount(){
        let data = """
            {
            "poiList": [
                {
                "id": -479925044,
                "coordinate": {
                    "latitude": 53.5530854,
                    "longitude": 9.955689
                },
                "state": "INACTIVE",
                "type": "TAXI",
                "heading": 0.0
                },{
                "id": 743402081,
                "coordinate": {
                    "latitude": 53.585491577106666,
                    "longitude": 9.98225922767678
                },
                "state": "ACTIVE",
                "type": "TAXI",
                "heading": 233.87039184570312
                },{
                "id": 743402081,
                "coordinate": {
                    "latitude": 53.585491577106666,
                    "longitude": 9.98225922767678
                 },
                "state": "ACTIVE",
                "type": "TAXI",
                "heading": 233.87039184570312
                }
                ]
            }
            """.data(using: .utf8)
        let d = try! JSONDecoder().decode(PoiListResponse.self, from: data!)
        sut.list = d.poiList
        XCTAssertNotNil(sut.markerViewModels)
        XCTAssertEqual(sut.list.count, sut.markerViewModels.count)
    }

}

//
//  TestPoiListservice.swift
//  freeNowiOSCodeChallengeTests
//
//  Created by kjoe on 11/16/20.
//

import XCTest
@testable import freeNowiOSCodeChallenge
class TestPoiListservice: XCTestCase {
    var sut: RemotePoiListService!

    override func setUpWithError() throws {
        let loader = FakeNetworkLoader()
        sut = RemotePoiListService(loader: loader)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    func test_requestWithValidParamsIsNotNilURL(){
        let req = sut.createRequest(lat0: 0.0, Lon0: 0.0, Lat1: 0.0, Lon1: 0.0)
        XCTAssertNotNil(req)
        XCTAssertEqual(req?.url?.description, "https://poi-api.mytaxi.com/PoiService/poi/v1?p1Lat=0.0&p1Lon=0.0&p2Lat=0.0&p2Lon=0.0")
    }
    
    func test_WithValidValuesClosureIsSuccess(){
        let exp = XCTestExpectation(description: "A data or error is returned ")
        _ = sut.getPoiList(lat0: 0.0, Lon0: 0.0, Lat1: 0.0, Lon1: 0.0, completion: { r in
            switch r{
            case.success(let dat):
                XCTAssertNotNil(dat)
                XCTAssertEqual(dat.poiList?.count,3)
                exp.fulfill()
            case .failure(let e):
                XCTAssertNotNil(e)
                XCTAssertEqual(e.localizedDescription, customError.badRequest.localizedDescription)
                exp.fulfill()
            }
        })
    }
    func test_withInvalidRequestParamsIsFailure(){
        sut.loader = badNetworkRequest()
        let exp = XCTestExpectation(description: "A failure has ocurred")
        _ = sut.getPoiList(lat0: 0.0, Lon0: 0.0, Lat1: 0.0, Lon1: 0.0, completion: { r in
            switch r{
            case .failure(let e):
                XCTAssertNotNil(e)
                XCTAssertEqual(e.localizedDescription, customError.badRequest.localizedDescription)
                exp.fulfill()
            case .success(_):
                XCTFail()
            }
        })
    }
    
    
   
   


}

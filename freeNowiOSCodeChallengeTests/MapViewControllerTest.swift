//
//  MapViewControllerTest.swift
//  freeNowiOSCodeChallengeTests
//
//  Created by kjoe on 11/17/20.
//

import XCTest
@testable import freeNowiOSCodeChallenge
import GoogleMaps
import GoogleMapsUtils
class MapViewControllerTest: XCTestCase {

    var sut: MapViewController!
    override func setUpWithError() throws {
        sut = UIStoryboard(name: "Map", bundle: nil).instantiateInitialViewController() as? MapViewController
        sut.viewModel = DIContaier.createMapViewModel()
        sut.viewModel.p1 = Coordinate(latitude: 0.0, longitude: 0.0)
        sut.viewModel.p2 = Coordinate(latitude: 0.0, longitude: 0.0)
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
       sut = nil
    }
    
    func test_MapIsNotNil(){
        XCTAssertNotNil(sut.map)
    }
    
    func test_ConformsToMapDelegate(){
        XCTAssertTrue(sut.conforms(to: GMSMapViewDelegate.self))
        XCTAssertTrue(sut.responds(to: #selector( sut.mapView(_:idleAt:) ) ) )
        XCTAssertTrue(sut.responds(to: #selector(sut.mapView(_:didTap:))))
    }
    func test_MapDelegateIsNotNil(){
        XCTAssertNotNil(sut.map.delegate)
    }
    
    func test_ConformanceToGMUClusterRendererDelegate(){
        XCTAssertTrue(sut.conforms(to: GMUClusterRendererDelegate.self))
    }

}

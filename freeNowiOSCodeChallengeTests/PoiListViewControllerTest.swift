//
//  PoiListViewControllerTest.swift
//  freeNowiOSCodeChallengeTests
//
//  Created by kjoe on 11/13/20.
//

import XCTest
@testable import freeNowiOSCodeChallenge
class PoiListViewControllerTest: XCTestCase {
    var sut: PoiListViewController!
    var vm: PoiListViewModel!
    var service: MockPolistService!
    
    override func setUpWithError() throws {
        let nc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let sut = nc.viewControllers.first as! PoiListViewController
        //sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: String(describing: PoiListViewController.self))
        sut.loadViewIfNeeded()
        let service = MockPolistService()
        vm = PoiListViewModel(service: service)
        sut.viewModel = vm
    }

    override func tearDownWithError() throws {
        service = nil
        vm = nil
        sut = nil
    }
    func test_tableViewOutletNotNil(){
        XCTAssertNotNil(sut.tableView)
    }
    func test_TableViewDataSourceNotNil(){
        //Assert
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertNotNil(sut.tableView.delegate)
    }
    
    func test_TappingMapButtonPushMapViwController(){
        //Arrange
        let navigation = UINavigationController(rootViewController: sut)
        //Act
        tap(sut.mapButton)
        executeRunLoop()
        //Assert
        XCTAssertEqual(navigation.viewControllers.count, 2)
        //Arrange
        let vc = navigation.viewControllers.last
        guard let last = vc as? MapViewController else{
            XCTFail("Expected MapViewController, "
            + "but was \(String(describing: vc))")
            return
        }
        last.loadViewIfNeeded()
        //Assert
        XCTAssertEqual(last.title, "Map")
    }

//    func test_TavleViewCellOutletsNotNill(){
//        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! PoiTableViewCell
//        XCTAssertNotNil(cell.heading)
//        XCTAssertNotNil(cell.location)
//        XCTAssertNotNil(cell.status)
//        XCTAssertNotNil(cell.vehicleImage)
//        XCTAssertNotNil(cell.vehicleType)
//    }
    
    func test_ViewModelIsNotNill(){        
        sut.viewModel = DIContaier.createViewModel()
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.viewModel)
    }
   
}



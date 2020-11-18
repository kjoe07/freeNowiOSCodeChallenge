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
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: String(describing: PoiListViewController.self))
        let service = MockPolistService()
        vm = PoiListViewModel(service: service)
        sut.viewModel = vm
        sut.loadViewIfNeeded()
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
    func test_ConformsToUITableViewDataSourceAndUITableViewDelegate(){
        XCTAssertTrue(sut.tableView.dataSource is PoiListViewController)
        XCTAssertTrue(sut.tableView.delegate is PoiListViewController)
        XCTAssertTrue(sut.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(sut.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:cellForRowAt:))))
    }
    
    func test_TableViewCellHasReuseIdentifier() {
        let poi = createSinglePoi()
        sut.viewModel.poiCellViewModel = [PoiTableViewCellViewModel(poi: poi)]
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? PoiTableViewCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "cell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
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
    
    func test_ViewModelIsNotNill(){        
        sut.viewModel = DIContaier.createViewModel()
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.viewModel)
    }
    
    func createSinglePoi() -> Poi{
        let data = """
                {
                "id": -479925044,
                "coordinate": {
                    "latitude": 53.5530854,
                    "longitude": 9.955689
                },
                "state": "INACTIVE",
                "type": "TAXI",
                "heading": 0.0
                }
            """.data(using: .utf8)
        //guard let data = dataString else {return }
        let poi = try! JSONDecoder().decode(Poi.self, from: data!)
        return poi
    }
   
}



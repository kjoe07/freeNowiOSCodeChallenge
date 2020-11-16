//
//  MocPolistService.swift
//  freeNowiOSCodeChallengeTests
//
//  Created by kjoe on 11/16/20.
//

import Foundation
@testable import freeNowiOSCodeChallenge
import XCTest
final class MockPolistService: PoilistService{
    
    
    private var changeCallCount = 0
    private var changeArgsp1Lat: [Double] = []
    private var changeArgsp1Lon: [Double] = []
    private var changeArgsp2Lat: [Double] = []
    private var changeArgsp2Lon: [Double] = []
    
    
    func getPoiList(lat0: Double, Lon0: Double, Lat1: Double, Lon1: Double, completion: @escaping (Result<PoiListResponse, Error>) -> Void) -> NetworkCancelable? {
        changeCallCount += 1
        changeArgsp1Lat.append(lat0)
        changeArgsp1Lon.append(Lon0)
        changeArgsp2Lat.append(Lat1)
        changeArgsp2Lon.append(Lon1)
        return Cancelable()
    }
    
}

class Cancelable: NetworkCancelable{
    func cancel() {
    }
    
}
final class FakeNetworkLoader: NetworkLoader{
    func loadData(request: URLRequest?, completion: @escaping (Result<Data, Error>) -> Void) -> NetworkCancelable? {
        let cancel = Cancelable()
        if request != nil {
            let dataString = """
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
            guard let data = dataString else {return cancel}
            completion(.success(data))
        }else{
            completion(.failure(customError.badRequest))
        }
        return cancel
    }
}

final class badNetworkRequest: NetworkLoader{
    func loadData(request: URLRequest?, completion: @escaping (Result<Data, Error>) -> Void) -> NetworkCancelable? {
        completion(.failure(customError.badRequest))
        return nil
    }
    
    
}

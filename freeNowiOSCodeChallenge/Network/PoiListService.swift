//
//  PoiListService.swift
//  freeNowiOSCodeChallenge
//
//  Created by kjoe on 11/16/20.
//

import Foundation
protocol PoilistService{
    func getPoiList(lat0: Double,Lon0:Double,Lat1:Double,Lon1:Double,completion: @escaping (Result<PoiListResponse,Error>)-> Void)  -> NetworkCancelable?
}
class RemotePoiListService:PoilistService{
    
    var loader: NetworkLoader
    
    func getPoiList(lat0: Double, Lon0: Double, Lat1: Double, Lon1: Double, completion: @escaping (Result<PoiListResponse,Error>) -> Void) -> NetworkCancelable? {
         let r = createRequest(lat0: lat0, Lon0: Lon0, Lat1: Lat1, Lon1: Lon1) //else {return nil}
        return loader.loadData(request: r, completion: {result in
            switch result{
            case .success(let d):
                do{
                    let resp = try JSONDecoder().decode(PoiListResponse.self, from: d)
                    completion(.success(resp))
                }catch{
                    completion(.failure(error))
                }
            case .failure(let e):
                completion(.failure(e))
            }
        })
    }
    init(loader: NetworkLoader) {
        self.loader = loader
    }
    
    func createRequest(lat0: Double, Lon0: Double, Lat1: Double, Lon1: Double) -> URLRequest?{
        let end =  PoilistEndpoint(path: "/PoiService/poi/v1", queryItems: [ URLQueryItem(name: "p1Lat", value: "\(lat0)"),URLQueryItem(name: "p1Lon", value: "\(Lon0)"),URLQueryItem(name: "p2Lat", value: "\(Lat1)"),URLQueryItem(name: "p2Lon", value: "\(Lon1)")] )
        guard let url = end.url else {return nil}
            let request = URLRequest(url: url)
            return request
        
    }
    
}

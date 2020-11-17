//
//  MapViewModel.swift
//  freeNowiOSCodeChallenge
//
//  Created by kjoe on 11/16/20.
//

import Foundation
import GoogleMaps
protocol MapViewModelDelegate {
    
}
class MapViewModel{
    var service: PoilistService
    var p1: Coordinate!
    var p2:Coordinate!
    var list: [Poi]!{
        didSet{
            self.markerViewModels = self.list.map({
                self.viewModelFor(poi: $0)
            })
        }
    }
    var task: NetworkCancelable?
    var isActivityIndicatorShowing = false
    
    var didUpdate: (() -> Void )?
    var isUpdating: ((Bool) -> Void )?
    var didError: ((Error) -> Void )?
    var markerViewModels = [MarkerViewModel](){
        didSet{
            print("set markersVM",markerViewModels.count)
            self.didUpdate?()
           // print("did update is ",self.didUpdate?() as Any)
        }
    }
    
    init(service: PoilistService) {
        self.service = service
    }
    
    func setInitialpoints(p1:Coordinate,p2:Coordinate){
        self.p1 = p1
        self.p2 = p2
    }
    
    func updateVehicles(p1: CLLocationCoordinate2D,p2:CLLocationCoordinate2D){
        self.isUpdating?(true)
        loadVehicles(p1Lat: p1.latitude, p1Lon: p1.longitude, p2Lat: p2.latitude, p2Lon: p2.longitude)
    }
    
    func loadVehicles(p1Lat: Double,p1Lon:Double,p2Lat:Double,p2Lon:Double){
        task =  service.getPoiList(lat0: p1Lat, Lon0: p1Lon, Lat1: p2Lat, Lon1: p2Lon, completion: {[weak self] result in
            guard let self = self else {return}
            self.isUpdating?(false)
            switch result{
            case .success(let d):
                self.list = d.poiList ?? []
            case .failure(let e):
                self.didError?(e)
            }
        })
    }
    private func viewModelFor(poi: Poi) -> MarkerViewModel {
        let viewModel = MarkerViewModel(poi: poi)
        return viewModel
    }
    
}


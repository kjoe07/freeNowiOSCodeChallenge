//
//  MarkerViewModel.swift
//  freeNowiOSCodeChallenge
//
//  Created by kjoe on 11/17/20.
//

import Foundation
import GoogleMaps
class MarkerViewModel{
    var title: String{
        return poi.type ?? ""
    }
    var location: CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: poi.coordinate?.latitude ?? 0, longitude: poi.coordinate?.longitude ?? 0)
    }
    
    var state:String{
        return poi.state == "ACTIVE" ? "Green" : "Red"
    }
    
    var poi: Poi
    
    init(poi: Poi){
        self.poi = poi
    }
}

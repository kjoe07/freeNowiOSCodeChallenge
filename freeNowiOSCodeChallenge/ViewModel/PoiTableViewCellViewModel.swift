//
//  PoiTableViewCellViewModel.swift
//  freeNowiOSCodeChallenge
//
//  Created by kjoe on 11/15/20.
//

import Foundation
class PoiTableViewCellViewModel{
    var poi: Poi?
    var vehicleType: String!{
        return poi?.type ?? ""
    }
    var vehilceLocation: String!{
        return "\(poi?.coordinate?.latitude?.rounded(toPlaces: 6) ?? 0.0),\(poi?.coordinate?.longitude?.rounded(toPlaces: 6) ?? 0.0)"
    }
    
    var heading: String{
        return self.windDirectionFromDegrees(degrees: poi?.heading ?? 0 )
    }
    
    func windDirectionFromDegrees(degrees : Double) -> String {
        let directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        let i: Int = Int((degrees + 11.25)/22.5)
        return directions[i % 16]
    }
    
    var status: String{
        return poi?.state ?? ""
    }
    
    var statusColor: String{
        return poi?.state == "ACTIVE" ? "Green": "Red"
    }
    
    var didSelectPoi: ((Poi) -> Void)?
    
    init(poi: Poi) {
        self.poi = poi
    }
    
    
    
}


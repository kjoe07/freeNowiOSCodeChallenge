//
//  PoiItem.swift
//  freeNowiOSCodeChallenge
//
//  Created by kjoe on 11/17/20.
//

import Foundation
import GoogleMapsUtils
class POIItem: NSObject, GMUClusterItem {
    var position: CLLocationCoordinate2D
    var name: String!
    let marker: GMSMarker

    init(position: CLLocationCoordinate2D, name: String, marker: GMSMarker ) {
        self.position = position
        self.name = name
        self.marker = marker
  }
}

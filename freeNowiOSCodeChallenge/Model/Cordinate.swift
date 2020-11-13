//
//  Cordinate.swift
//  freeNowiOSCodeChallenge
//
//  Created by kjoe on 11/13/20.
//

import Foundation
struct Coordinate : Decodable {
    let latitude : Double?
    let longitude : Double?

    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
    }

}

//
//  PoiList.swift
//  freeNowiOSCodeChallenge
//
//  Created by kjoe on 11/13/20.
//

import Foundation
struct PoiList : Decodable {
    let id : Int?
    let coordinate : Coordinate?
    let state : String?
    let type : String?
    let heading : Double?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case coordinate = "coordinate"
        case state = "state"
        case type = "type"
        case heading = "heading"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        coordinate = try values.decodeIfPresent(Coordinate.self, forKey: .coordinate)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        heading = try values.decodeIfPresent(Double.self, forKey: .heading)
    }

}

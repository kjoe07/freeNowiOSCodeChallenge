//
//  PoiListResponse.swift
//  freeNowiOSCodeChallenge
//
//  Created by kjoe on 11/13/20.
//

import Foundation
struct PoiListResponse : Decodable {
    let poiList : [PoiList]?

    enum CodingKeys: String, CodingKey {
        case poiList = "poiList"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        poiList = try values.decodeIfPresent([PoiList].self, forKey: .poiList)
    }

}

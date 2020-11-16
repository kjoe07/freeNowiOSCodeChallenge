//
//  Endpoint.swift
//  freeNowiOSCodeChallenge
//
//  Created by kjoe on 11/16/20.
//

import Foundation
protocol Endpoint {
    var path: String { get set}
    var queryItems: [URLQueryItem]? { get set}
}
extension Endpoint {
    // We still have to keep 'url' as an optional, since we're
    // dealing with dynamic components that could be invalid.
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "poi-api.mytaxi.com"
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}

struct PoilistEndpoint:Endpoint{
    var path: String
    var queryItems: [URLQueryItem]?    
    
}

//
//  DIContainer.swift
//  freeNowiOSCodeChallenge
//
//  Created by kjoe on 11/16/20.
//

import Foundation
class DIContaier {
    static func createViewModel() -> PoiListViewModel{
        let loader = CustomNetWorkLoader(session: URLSession.shared)
        let service = RemotePoiListService(loader: loader)
        let vm = PoiListViewModel(service: service)
        return vm
    }
    static func createMapViewModel()-> MapViewModel{
        let loader = CustomNetWorkLoader(session: URLSession.shared)
        let service = RemotePoiListService(loader: loader)
        let vm = MapViewModel(service: service)
        return vm
    }
}

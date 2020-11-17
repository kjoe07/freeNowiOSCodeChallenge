//
//  PoiListViewModel.swift
//  freeNowiOSCodeChallenge
//
//  Created by kjoe on 11/15/20.
//

import Foundation
class PoiListViewModel{
    var isActivityIndicatorShowing = false
    var isTableViewDataUpdate = false
    
    var list: [Poi]?{
        didSet {
            isUpdating?(false)
            didUpdate?()            
        }
    }
    
    var poiCellViewModel = [PoiTableViewCellViewModel]()
    var service: PoilistService
    var task: NetworkCancelable?
    var didUpdate: (()->Void)?
    var isUpdating: ((Bool)->Void)?
    var didSelectPoi: ((Poi) -> Void)?
    var didError: ((Error)->Void)?
    
    init(service: PoilistService){
        self.service = service
    }
    
    
    func loadData(){
        self.isUpdating?(true)
        self.task =   service.getPoiList(lat0: 53.694865, Lon0: 9.757589, Lat1: 53.394655, Lon1: 10.099891, completion: {[weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let list):
                self.list = list.poiList
                self.poiCellViewModel = list.poiList?.map({
                    self.viewModelFor(poi: $0)
                }) ?? []
            case .failure(let e):
                print(e.localizedDescription)
                self.didError?(e)
            }
        })
    }
    
    private func viewModelFor(poi: Poi) -> PoiTableViewCellViewModel {
        let viewModel = PoiTableViewCellViewModel(poi: poi)
        viewModel.didSelectPoi = { [weak self] poi in
            self?.didSelectPoi?(poi)
        }
        return viewModel
    }
    
    func viewWillDissapear(){
        task?.cancel()
    }
    
    
}

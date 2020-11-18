//
//  MapViewController.swift
//  freeNowiOSCodeChallenge
//
//  Created by kjoe on 11/13/20.
//

import UIKit
import GoogleMaps
import GoogleMapsUtils
import ActivityIndicator
class MapViewController: UIViewController,GMSMapViewDelegate,GMUClusterManagerDelegate,GMUClusterRendererDelegate {
   
    @IBOutlet weak var map: GMSMapView!
    var viewModel:  MapViewModel!
    var clusterManager: GMUClusterManager!
    var renderer: GMUDefaultClusterRenderer!
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        let bound = GMSCoordinateBounds(coordinate: CLLocationCoordinate2D(latitude: viewModel.p1.latitude ?? 0 , longitude: viewModel.p1.longitude ?? 0), coordinate: CLLocationCoordinate2D(latitude: viewModel.p2.latitude ?? 0, longitude: viewModel.p2.longitude ?? 0))
        map.animate(with: GMSCameraUpdate.fit(bound, withPadding: 0.0))
        viewModel.loadVehicles(p1Lat: viewModel.p1.latitude ?? 0, p1Lon: viewModel.p1.longitude ?? 0, p2Lat: viewModel.p2.latitude ?? 0, p2Lon: viewModel.p2.longitude ?? 0)
        self.bindToViewModel()
       
        renderer = GMUDefaultClusterRenderer(mapView: self.map,clusterIconGenerator: viewModel.iconGenerator)
        renderer.delegate = self //as? GMUClusterRendererDelegate
        self.clusterManager = GMUClusterManager(map: self.map, algorithm: viewModel.algorithm,renderer: renderer)
        self.title = viewModel.title
    }
    
    func bindToViewModel(){
        self.viewModel.didError = { [weak self] e in
            DispatchQueue.main.async {
                self?.viewModelDidError(error: e)
            }
        }
        self.viewModel.isUpdating = { [weak self] flag in
            DispatchQueue.main.async {
                self?.updateActivity(flag: flag)
            }
        }
        viewModel.didUpdate = {[weak self] in
            DispatchQueue.main.async {
                self?.viewModelDidUpdate()
            }            
        }
    }

    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let bound = mapView.projection.visibleRegion()
        viewModel.updateVehicles(p1: bound.farLeft, p2: bound.nearRight)
    }
    
    func viewModelDidError(error: Error){
        self.hideActivityIndicator()
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    func updateActivity(flag:Bool){
        if flag{
            self.showActivityIndicator(color: UIColor(named: "green") ?? .green)
        }else{
            self.hideActivityIndicator()
        }
    }
    func viewModelDidUpdate(){
        print("data updated")
        map.clear()
        clusterManager.clearItems()
        for mar in viewModel.markerViewModels{
            let marker = GMSMarker()
            marker.position = mar.location
            marker.title = mar.title
            let imageV = CarImageView(frame: CGRect(x: 10, y: 0, width: 30, height: 30))
            imageV.borderColor =  UIColor(named: mar.state) ?? . green
            imageV.cornerRadius = 30/2
            imageV.image = #imageLiteral(resourceName: "sedan")
            marker.iconView = imageV
            //marker.map = map
            let item = viewModel.generateClusterItems(postion: mar.location, name: "", marker: marker)
            clusterManager.add(item)
        }
    }
    
    //MARK: - Clustermanager Functions
    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
        let newCamera = GMSCameraPosition.camera(withTarget: cluster.position,zoom: map.camera.zoom + 1)
        let update = GMSCameraUpdate.setCamera(newCamera)
        map.moveCamera(update)
        return true
    }
    func clusterManager(_ clusterManager: GMUClusterManager, didTap clusterItem: GMUClusterItem) -> Bool {
        return true
    }
    
    // MARK: - GMUMapViewDelegate
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let poiItem = marker.userData as? GMUCluster {
            let newCamera = GMSCameraPosition.camera(withTarget: poiItem.position,zoom: (mapView.camera.zoom + 3))
            let update = GMSCameraUpdate.setCamera(newCamera)
            mapView.moveCamera(update)
        }
        return false
    }
    func renderer(_ renderer: GMUClusterRenderer, willRenderMarker marker: GMSMarker) {
        if !(marker.userData is GMUCluster){
            let mar = marker.userData as? GMUClusterItem
            let custommarker = (mar as? POIItem)?.marker
            marker.iconView = custommarker?.iconView
        }
    }
    func renderer(_ renderer: GMUClusterRenderer,  object: Any) -> GMSMarker? {
        if object is GMUCluster{
            print("is cluster")
        }else{
            print("is item")
            let mar = (object as? POIItem)?.marker
            return mar
        }
        return GMSMarker()
    }
    
}

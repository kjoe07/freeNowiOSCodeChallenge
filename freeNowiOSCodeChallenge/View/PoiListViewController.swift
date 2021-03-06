//
//  PoiListViewController.swift
//  freeNowiOSCodeChallenge
//
//  Created by kjoe on 11/13/20.
//

import UIKit
import Network
class PoiListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapButton: UIBarButtonItem!
    
    var activity = UIActivityIndicatorView(style: .large)
    let monitor = NWPathMonitor()
    var viewModel: PoiListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DIContaier.createViewModel()
        bindToViewModel()
        viewModel.loadData()
    }
    
    private func bindToViewModel() {
        self.viewModel.didUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.updateTableView()
            }
        }
        self.viewModel.didError = { [weak self] error in
            DispatchQueue.main.async {
                self?.viewModelDidError(error: error)
            }
        }
        self.viewModel.isUpdating = { [weak self] flag in
            DispatchQueue.main.async {
                self?.updateActivity(flag: flag)
            }            
        }
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! MapViewController
        vc.viewModel = DIContaier.createMapViewModel()
        vc.viewModel.setInitialpoints(p1: Coordinate(latitude: 53.694865, longitude: 9.757589) , p2: Coordinate(latitude: 53.394655, longitude: 10.099891))
        vc.viewModel.list = viewModel.list
    }
    
    func updateActivity(flag: Bool){
        DispatchQueue.main.async {
            if flag{
                self.showActivityIndicator(color: UIColor(named: "Green") ?? .green)
            }else{
                self.hideActivityIndicator()
            }
        }
    }
    
    func updateTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func viewModelDidError(error: Error){
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    func NetworkMonitor(){
        monitor.pathUpdateHandler = { path in
            if path.status != .satisfied {
                print("No connection.")
                 DispatchQueue.main.async {
                     self.viewModel.task?.cancel()
                     self.NoInternetAlert()
                 }
            }
            print(path.isExpensive)
        }
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
    }
    func NoInternetAlert(){
        let alert = UIAlertController(title: "Offline", message: "there is not internet conection detected.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
extension PoiListViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.list?.count ?? 0 == 0{
            tableView.setEmptyView(title: "No data", message: "there is no avaible data", imageString: "emptyShoping")
        }else{
            tableView.restore()
        }
        return viewModel.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PoiTableViewCell
        cell.setup(vm: viewModel.poiCellViewModel[indexPath.row])
        return cell
    }
    
    
}

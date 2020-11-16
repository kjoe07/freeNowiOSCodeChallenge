//
//  PoiListViewController.swift
//  freeNowiOSCodeChallenge
//
//  Created by kjoe on 11/13/20.
//

import UIKit

class PoiListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapButton: UIBarButtonItem!
    
    var activity = UIActivityIndicatorView(style: .large)
    
    var viewModel: PoiListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setActivityIndicator()
        viewModel.loadData()
        bindToViewModel()
        
    }
    
    private func bindToViewModel() {
        self.viewModel.didUpdate = { [weak self] in
            self?.updateTableView()
        }
        self.viewModel.didError = { [weak self] error in
            self?.viewModelDidError(error: error)
        }
        self.viewModel.isUpdating = { [weak self] flag in
            self?.updateActivity(flag: flag)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func setActivityIndicator(){
        activity.isHidden = true
        activity.hidesWhenStopped = true
        activity.color = .green
        activity.center = self.view.center
        self.view.addSubview(activity)
        activity.startAnimating()
    }
    
    func updateActivity(flag: Bool){
        DispatchQueue.main.async {
            if flag{
                self.activity.isHidden = false
                self.activity.startAnimating()
            }else{
                self.activity.stopAnimating()
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

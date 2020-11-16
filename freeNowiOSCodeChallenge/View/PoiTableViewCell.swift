//
//  PoiTableViewCell.swift
//  freeNowiOSCodeChallenge
//
//  Created by kjoe on 11/13/20.
//

import UIKit

class PoiTableViewCell: UITableViewCell {
    @IBOutlet weak var vehicleType: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var status: RoundedButton!
    @IBOutlet weak var vehicleImage: CarImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(vm: PoiTableViewCellViewModel){
        vehicleType.text = vm.vehicleType
        location.text = vm.vehilceLocation
        heading.text = vm.heading
        status.setTitle(vm.status, for: .normal)
        status.backgroundColor = UIColor(named: vm.statusColor) ?? .red
        vehicleImage.layer.borderColor = (UIColor(named: vm.statusColor) ?? .red).cgColor
    }

}

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

}

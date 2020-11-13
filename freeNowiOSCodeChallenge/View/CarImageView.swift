//
//  CarImageView.swift
//  freeNowiOSCodeChallenge
//
//  Created by kjoe on 11/13/20.
//

import UIKit
@IBDesignable class CarImageView: UIImageView {
    @IBInspectable var borderColor: UIColor = UIColor.orange{
        didSet{
            self.applyCornerRadius()
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 56/2 {
        didSet{
            self.applyCornerRadius()
        }
    }
    @IBInspectable var borderWidth: CGFloat = 2 {
        didSet{
            self.applyCornerRadius()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyCornerRadius()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyCornerRadius()
    }
    
    func applyCornerRadius(){
        self.layer.cornerRadius = self.bounds.size.height/2
        self.layer.masksToBounds = true
        self.layer.borderColor = self.borderColor.cgColor
        self.layer.borderWidth = self.borderWidth        
    }
}

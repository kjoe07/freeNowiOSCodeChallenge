//
//  MarkerLabel.swift
//  freeNowiOSCodeChallenge
//
//  Created by kjoe on 11/17/20.
//

import UIKit
class MarkerLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            backgroundColor = .black
        }
        textAlignment = .center
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        font = .systemFont(ofSize: 12)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

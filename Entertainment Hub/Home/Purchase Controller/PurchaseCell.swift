//
//  PurchaseCell.swift
//  Entertainment Hub
//
//  Created by Michael Lema on 4/29/19.
//  Copyright © 2019 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class PurchaseCell: UICollectionViewCell {
    
    let sourceFormatLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sourceFormatLabel)
        
        sourceFormatLabel.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 12, paddingRight: 12, width: 0, height: 0)
    }
    
}

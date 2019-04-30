//
//  PurchaseHeaderCell.swift
//  Entertainment Hub
//
//  Created by Michael Lema on 4/29/19.
//  Copyright © 2019 Michael Lema. All rights reserved.
//

import UIKit


class PurchaseHeaderCell: UICollectionViewCell {


    var servicePath: String?
    
    lazy var sourceButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(redirectToService), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func redirectToService() {
        print(servicePath!)
        guard let serviceURL = URL(string: servicePath!) else { return }
        UIApplication.shared.open(serviceURL)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sourceButton)
       
        sourceButton.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 12, paddingRight: 12, width: 0, height: 0)
    }

}

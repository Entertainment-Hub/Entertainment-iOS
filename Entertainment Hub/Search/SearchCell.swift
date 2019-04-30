//
//  SearchBar.swift
//  Entertainment Hub
//
//  Created by Michael Lema on 4/28/19.
//  Copyright © 2019 Michael Lema. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    var result: SearchResult? {
        didSet {
            guard let result = self.result else { return }
            guard let url = URL(string: result.artwork608X342) else { return }
            profileImageView.kf.setImage(with:url)
            titleLabel.text = result.title
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Title"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        addSubview(separatorView)
        addSubview(profileImageView)
        addSubview(titleLabel)
        profileImageView.anchor(top: nil, bottom: nil, left: leftAnchor, right: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 8, paddingRight: 0, width: 50, height: 50)
        profileImageView.layer.cornerRadius = 50 / 2
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        titleLabel.anchor(top: topAnchor, bottom: bottomAnchor, left: profileImageView.rightAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 8, paddingRight: 0, width: 0, height: 0)
        
        separatorView.anchor(top: nil, bottom: bottomAnchor, left: titleLabel.leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

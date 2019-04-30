//
//  TitlePhotoCell.swift
//  Entertainment Hub
//
//  Created by Michael Lema on 4/29/19.
//  Copyright © 2019 Michael Lema. All rights reserved.
//

import UIKit

class TitlePhotoCell: UICollectionViewCell {
    
    var result: TitleResult? {
        didSet {
            //artwork608X342
            guard let result  = self.result else { return }
            let artworkPath: String? = result.poster400X570  ?? result.artwork608X342
            guard let path = artworkPath else { return }
            guard let url = URL(string: path) else { return }
            photoImageView.kf.setImage(with:url)
            
        }
    }
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

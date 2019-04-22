//
//  DOExploreCollectionCell.swift
//  Entertainment Hub
//
//  Created by Michael Lema on 2/23/19.
//  Copyright © 2019 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

public final class DOExploreCollectionCell: UICollectionViewCell {
    public let imageView = UIImageView()
    public let gradientView = GradientView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        clipsToBounds = true
        layer.backgroundColor = UIColor.darkGray.cgColor
        
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        addSubview(gradientView)
        
        imageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
    
        NSLayoutConstraint.activate([
            gradientView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5, constant: 0.0),
            gradientView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            gradientView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            gradientView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ])
    }
}

open class GradientView: UIView {
    open override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        isUserInteractionEnabled = false
        clipsToBounds = true
        backgroundColor = nil
        gradientLayer?.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer?.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer?.colors = [
            UIColor.black.withAlphaComponent(0.8),
            UIColor.black.withAlphaComponent(0.0),
            ].compactMap({ $0.cgColor })
        gradientLayer?.locations = [0.0, 1.0].map({ NSNumber(value: $0) })
        gradientLayer?.rasterizationScale = UIScreen.main.scale
        gradientLayer?.shouldRasterize = true
    }
    
    public var gradientLayer: CAGradientLayer? {
        return layer as? CAGradientLayer
    }
    
    public override static var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}

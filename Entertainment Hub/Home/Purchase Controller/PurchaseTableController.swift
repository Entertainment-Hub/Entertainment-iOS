//
//  PurchaseTableController.swift
//  Entertainment Hub
//
//  Created by Michael Lema on 4/29/19.
//  Copyright © 2019 Michael Lema. All rights reserved.
//

import Foundation
import UIKit




class PurchaseTableController: UICollectionViewController {
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    var purchaseWebSources: [PurchaseWebSource]? {
        didSet {
            guard self.purchaseWebSources != nil else { return }
            self.collectionView.reloadData()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.App.gray
        collectionView.register(PurchaseCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(PurchaseHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
}

// MARK: UICollectionViewDataSource
extension PurchaseTableController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PurchaseHeaderCell
        header.backgroundColor = UIColor.App.darkGray
        guard let websources = self.purchaseWebSources else { return header }
        header.sourceButton.setTitle(websources[indexPath.section].displayName, for: .normal)
        header.servicePath = websources[indexPath.section].link
//        print(websources[indexPath.section].link)
        return header
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let websources = self.purchaseWebSources else { return 0 }
        guard let formats = websources[section].formats else { return 0 }
        return formats.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PurchaseCell
        cell.backgroundColor = .clear
        guard let websources = self.purchaseWebSources else { return cell }
        guard let formats = websources[indexPath.section].formats else { return cell}
        let format = formats[indexPath.item]
        print(format)
        guard let type = format.type,
            let quality = format.format,
            let price = format.price else { return cell }
        let textOutput = type.capitalized + " \(quality.uppercased()) " + "$\(price)"
        cell.sourceFormatLabel.text = textOutput
        return cell

    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return purchaseWebSources?.count ?? 0
    }
}

extension PurchaseTableController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: view.frame.width, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

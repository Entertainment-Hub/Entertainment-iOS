//
//  MovieController.swift
//  Entertainment Hub
//
//  Created by Michael Lema on 2/23/19.
//  Copyright © 2019 Michael Lema. All rights reserved.
//

import Foundation
import UIKit


class TitleController: UICollectionViewController {

    let cellId = "cellId"
    let headerId = "headerId"
    let postCellId = "homePostCellId"
    
    var results: MovieResult? {
        didSet {
            print(results?.originalTitle)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.App.darkGray
    }
    
}

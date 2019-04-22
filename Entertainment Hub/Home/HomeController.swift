//
//  HomeController.swift
//  Entertainment Hub
//
//  Created by Michael Lema on 2/23/19.
//  Copyright © 2019 Michael Lema. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class HomeController: UIViewController {    
    let request = RequestMovies()
    let netflixMovies = SubscriptionMovies(from: .netflix)
    let amazonPrimeMovies = SubscriptionMovies(from: .amazonPrime)
    let huluMovies = SubscriptionMovies(from: .hulu)
    var headerNames = ["", "Netflix", "Amazon Prime", "Hulu"]
    var moviesArray = [[MoviesResult]]()

    override func loadView() {
        view = UICollectionView(frame: .zero, collectionViewLayout: DOExploreCollectionLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.App.darkGray
        collectionView?.dataSource = self
        collectionView?.register(DOExploreCollectionCell.self, forCellWithReuseIdentifier: String(describing: DOExploreCollectionCell.self))
        collectionView?.register(DOExploreHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: String(describing: DOExploreHeaderView.self))
        layout?.sectionHeaderHeight = 27
        layout?.heroHeight = 240
        layout?.itemSize = CGSize(width: 150, height: 250)
        layout?.stickyHero = true
        layout?.delegate = self
        
       getMovies()
    }
    
    fileprivate func getMovies() {
        guard let netflixMovies = netflixMovies.allMovies(),
        let amazonPrimeMovies =  amazonPrimeMovies.allMovies(),
        let huluMovies = huluMovies.allMovies() else { return }
        moviesArray.append(amazonPrimeMovies)
        moviesArray.append(netflixMovies)
        moviesArray.append(amazonPrimeMovies)
        moviesArray.append(huluMovies)
        /*
        print(netflixMovies)
        print("----------")
        print(amazonPrimeMovies)
        print("----------")
        print(huluMovies)*/
    }
    
    var collectionView: UICollectionView? {
        return view as? UICollectionView
    }
    
    var layout: DOExploreCollectionLayout? {
        return collectionView?.collectionViewLayout as? DOExploreCollectionLayout
    }
    
    func typeForSection(section: Int) -> DOSectionType {
        return section % 5 == 0 ? .hero : .normal
    }
    
}

// MARK: DOExploreCollectionLayoutDelegate
extension HomeController: DOExploreCollectionLayoutDelegate {
    
    func collectionView(_: UICollectionView?, layout _: DOExploreCollectionLayout, typeForSectionAt section: Int) -> DOSectionType {
        return typeForSection(section: section)
    }
}

// MARK: UICollectionViewDataSource
extension HomeController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let identifier = String(describing: DOExploreHeaderView.self)
        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath)
        let header = reusableView as? DOExploreHeaderView
        header?.titleLabel.text = headerNames[indexPath.section]
        return reusableView
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let type = typeForSection(section: indexPath.section)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DOExploreCollectionCell.self), for: indexPath)
        let exploreCell = cell as? DOExploreCollectionCell
        exploreCell?.gradientView.isHidden = type == .normal
        
        //let imageName = (type == .normal ? "Poster" : "Backdrop") + String((indexPath.row + indexPath.section) % 7)
        if indexPath.section == 0 {
            exploreCell?.imageView.contentMode = .scaleAspectFill
        }
        let url = URL(string: moviesArray[indexPath.section][indexPath.item].poster400X570)
        exploreCell?.imageView.kf.setImage(with: url)
        
        return cell
    }
    
    func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return 8 }
        return 25
    }
    
    func numberOfSections(in _: UICollectionView) -> Int {
        // The first section is the scroll display.
        return 4
    }
}

// MARK: Configuring status bar and NavBar

extension HomeController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
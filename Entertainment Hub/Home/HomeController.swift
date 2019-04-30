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
import MKProgress

class HomeController: UIViewController {    
    let request = RequestMovies()
    
    let netflix = Subscription(from: .netflix)
    let amazonPrime = Subscription(from: .amazonPrime)
    let itunes = Subscription(from: .itunes)
    let hulu = Subscription(from: .hulu)
    
    var headerNames = ["Amazon Prime", "Netflix", "iTunes", "Hulu"]
    var moviesArray = [[TitleResult]]()
    var showsArray = [[TitleResult]]()
    
    lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Movies","Shows"])
        sc.tintColor = UIColor.App.orange
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    override func loadView() {
        view = UICollectionView(frame: .zero, collectionViewLayout: DOExploreCollectionLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.App.darkGray
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(DOExploreCollectionCell.self, forCellWithReuseIdentifier: String(describing: DOExploreCollectionCell.self))
        collectionView?.register(DOExploreHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: String(describing: DOExploreHeaderView.self))
        layout?.sectionHeaderHeight = 27
        layout?.heroHeight = 240
        layout?.itemSize = CGSize(width: 150, height: 250)
        layout?.stickyHero = true
        layout?.delegate = self
        
        getMovies()
        getShows()
        setupSegmentedControl()
    }
    
    fileprivate func setupSegmentedControl() {
        segmentedControl.addTarget(self, action: #selector(handleChange), for: .valueChanged)
        self.view.addSubview(segmentedControl)
        segmentedControl.anchor(top: self.view.topAnchor, bottom: nil, left: nil, right: nil, paddingTop: 220, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 150, height: 40)
        segmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    @objc fileprivate func handleChange() {
        MKProgress.show(after: 0.1, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.collectionView?.reloadData()
            MKProgress.hide(true)
        }
       
    }
    
    fileprivate func getMovies() {
        guard let netflixMovies = netflix.allMovies(),
            let amazonPrimeMovies =  amazonPrime.allMovies(),
            let huluMovies = hulu.allMovies(),
            let itunesMovies = itunes.allMovies() else { return }
        moviesArray.append(amazonPrimeMovies)
        moviesArray.append(netflixMovies)
        moviesArray.append(itunesMovies)
        moviesArray.append(huluMovies)
    }
    fileprivate func getShows() {
        guard let netflixShows = netflix.allShows(),
            let amazonPrimeShows =  amazonPrime.allShows(),
            let huluShows = hulu.allShows(),
            let itunesShows = itunes.allShows() else { return }
        showsArray.append(amazonPrimeShows)
        showsArray.append(netflixShows)
        showsArray.append(itunesShows)
        showsArray.append(huluShows)
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
        //header?.backgroundColor = .red
        header?.titleLabel.text = headerNames[indexPath.section]
        print(headerNames[indexPath.section])
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
        

        var artworkPath: String?
        if segmentedControl.selectedSegmentIndex == 0 {
            artworkPath = (indexPath.section == 0) ? showsArray[indexPath.section][indexPath.item].artwork608X342 : moviesArray[indexPath.section][indexPath.item].poster400X570
        } else {
            artworkPath = showsArray[indexPath.section][indexPath.item].artwork608X342
        }
        
        guard let path = artworkPath else { return cell }
        let url = URL(string: path)
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

extension HomeController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.section, indexPath.item)
        
        let titleController = TitleController(collectionViewLayout: UICollectionViewFlowLayout())
        let selectedSegmentIndex = segmentedControl.selectedSegmentIndex == 0
        titleController.result = (selectedSegmentIndex) ? moviesArray[indexPath.section][indexPath.item] : showsArray[indexPath.section][indexPath.item]
        navigationController?.pushViewController(titleController, animated: true)        
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

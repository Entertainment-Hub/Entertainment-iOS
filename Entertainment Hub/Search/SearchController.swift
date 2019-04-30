//
//  SearchController.swift
//  Entertainment Hub
//
//  Created by Michael Lema on 2/23/19.
//  Copyright © 2019 Michael Lema. All rights reserved.
//

import UIKit

class SearchController: UICollectionViewController {
    
    let cellId = "cellId"
    
    var results = [SearchResult]()
    var filteredResults = [SearchResult]()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Enter Show Name"
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        searchBar.delegate = self
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.App.gray
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .onDrag
        
        setupSearchBar()
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchShowJSON()
        //searchShow(query: "How")
    }
    
    fileprivate func searchShow(query: String) {
        let show = GuideBox.search(.none)
        show.showSearch(query: query) { (searchResult, erroe) in
            guard let results = searchResult else { return }
            print("the results are: \(results.count)")
       
            DispatchQueue.main.async {
                self.results = results
                self.filteredResults = self.results
                self.collectionView.reloadData()
            }
        }
    }
    fileprivate func fetchShowJSON() {
        let shows = Subscription(from: .none)
        guard let searchShows = shows.allSearchShows() else { return }
        print(searchShows.count)
        self.results = searchShows
        self.filteredResults = self.results
        self.collectionView.reloadData()
    }
    
    fileprivate func setupSearchBar() {
        navigationController?.navigationBar.addSubview(searchBar)
        let navBar = navigationController?.navigationBar
        searchBar.anchor(top: navBar?.topAnchor, bottom: navBar?.bottomAnchor, left: navBar?.leftAnchor, right: navBar?.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 8, paddingRight: 8, width: 0, height: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.isHidden = false
    }
}

// MARK: UICollectionViewDataSource
extension SearchController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCell
        cell.result = self.filteredResults[indexPath.item]
        cell.backgroundColor = .clear
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension SearchController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchBar.isHidden = true
        searchBar.resignFirstResponder()
        //let user = filteredUsers[indexPath.item]
        //let userProfileController = UserProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        //userProfileController.user = user
        //navigationController?.pushViewController(userProfileController, animated: true)
    }
}

extension SearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 66)
    }
}

extension SearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredResults = results
        } else {
            self.filteredResults = self.results.filter { (result) -> Bool in
                return result.title.lowercased().contains(searchText.lowercased())
            }
        }
        self.collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        if !text.isEmpty {
            self.searchShow(query: text)
        }
        
    }
}

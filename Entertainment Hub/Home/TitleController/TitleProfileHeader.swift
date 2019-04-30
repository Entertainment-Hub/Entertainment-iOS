//
//  TitleProfileHeaderView.swift
//  Entertainment Hub
//
//  Created by Michael Lema on 4/29/19.
//  Copyright © 2019 Michael Lema. All rights reserved.
//

import UIKit
import Kingfisher

class TitleProfileHeader: UICollectionViewCell {
    
    
    weak var delegate:TitleController?

    var isMovie: Bool = false
    
    var result: TitleResult? {
        didSet {
            guard let result = self.result else { return }
            let artworkPath: String? = result.artwork608X342 ?? result.poster400X570
            guard let path = artworkPath else { return }
            guard let url = URL(string:path) else { return }
            titleDisplayButton.kf.setImage(with: url, for: .normal)
            
            titleLabel.text = result.title + " "
            if let releaseYear = result.releaseYear {
                titleLabel.text?.append(String(releaseYear))
                /* Only Movies have a release Year */
                isMovie = true
            } else {
                rottenButton.setImage(#imageLiteral(resourceName: "tv"), for: .normal)
            }
            makeMetadataRequest()
        }
    }
    
    var titleData: TitleMetadata? {
        didSet {
            guard let data = self.titleData else { return }
            DispatchQueue.main.async {
                self.titleDescription.text = data.overview
            }
        }
    }

    fileprivate func makeMetadataRequest() {
        let title = (isMovie) ? GuideBox.movies(.none) : GuideBox.shows(.none)
        guard let result = result else { return }
        title.titleMetadata(ID: String(result.id)) { (metadata, error) in
            guard let metadata = metadata else { return }
            //print(metadata.overview)
            self.titleData = metadata
        }
        
    }
    
    lazy var titleDisplayButton: UIButton = {
        let titleButton = UIButton(type: .custom)
        titleButton.addTarget(self, action: #selector(displayWebPurchases), for: .touchUpInside)
        return titleButton
    }()
    
    lazy var playButton: UIButton = {
        let playButton = UIButton(type: .custom)
        playButton.addTarget(self, action: #selector(displayWebPurchases), for: .touchUpInside)
        playButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        playButton.alpha = 0.6
        return playButton
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    let titleDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var imdbButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "IMDb"), for: .normal)
        button.addTarget(self, action: #selector(handleimdb), for: .touchUpInside)
        return button
    }()
    
    lazy var wikiButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "wiki"), for: .normal)
        button.addTarget(self, action: #selector(handleWiki), for: .touchUpInside)
        return button
    }()
    
    lazy var rottenButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "rotten"), for: .normal)
        button.addTarget(self, action: #selector(handleRotten), for: .touchUpInside)
        return button
    }()
    
    lazy var commonButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "common"), for: .normal)
        button.addTarget(self, action: #selector(handleCommon), for: .touchUpInside)
        return button
    }()
    
    lazy var metaButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "Metacritic"), for: .normal)
        button.addTarget(self, action: #selector(handleMeta), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func displayWebPurchases() {
        //TODO: FIX
        if isMovie {
            let purchaseController = PurchaseTableController(collectionViewLayout: UICollectionViewFlowLayout())
            guard let data = self.titleData else { return }
            purchaseController.purchaseWebSources = data.purchaseWebSources
            delegate?.navigationController?.pushViewController(purchaseController, animated: true)
        } else {
            /* Not suited for mobile */
//            guard let validPath = titleData?.url else { return }
//            guard let url = URL(string: validPath) else { return }
//            UIApplication.shared.open(url)
        }
    }
    
    @objc fileprivate func handleimdb() {
        guard let titleID = (isMovie) ? result?.imdb : result?.imdbID else { return }
        let path = "https://www.imdb.com/title/" + titleID
        guard let url = URL(string: path) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc fileprivate func handleWiki() {
        guard let titleID = result?.wikipediaID else { return }
        let path = "https://en.m.wikipedia.org/w/index.php?curid=" + "\(titleID)"
        guard let url = URL(string: path) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc fileprivate func handleRotten() {
        let path: String?
        if isMovie {
            guard let titleID = result?.rottentomatoes else { return }
            print(titleID)
            path = "https://www.rottentomatoes.com/m/" + "\(titleID)"
        } else {
            path = titleData?.tvCOM
        }
       
        guard let validPath = path else { return }
        guard let url = URL(string: validPath) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc fileprivate func handleCommon() {
        guard let path = (isMovie) ? result?.commonSenseMedia  : titleData?.commonSenseMedia else { return }
        guard let url = URL(string: path) else { return }
        UIApplication.shared.open(url)
    }
    @objc fileprivate func handleMeta() {
        guard let path = (isMovie) ? result?.metacritic : titleData?.metacritic else { return }
        guard let url = URL(string: path) else { return }
        UIApplication.shared.open(url)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleDisplayButton)
        addSubview(titleLabel)
        addSubview(titleDescription)
        titleDisplayButton.addSubview(playButton)
        
        titleDisplayButton.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: nil, paddingTop: 12, paddingBottom: 0, paddingLeft: 12, paddingRight: 0, width: 80, height: 130)
        titleDisplayButton.clipsToBounds = true
        
        setupBottomToolbar()
        
        titleLabel.anchor(top: nil, bottom: imdbButton.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 4, paddingBottom: 0, paddingLeft: 12, paddingRight: 12, width: 0, height: 50)
        
        titleDescription.anchor(top: titleDisplayButton.topAnchor, bottom: titleLabel.topAnchor, left: titleDisplayButton.rightAnchor, right: self.rightAnchor, paddingTop: 4, paddingBottom: 0, paddingLeft: 8, paddingRight: 6, width: 0, height: 0)
        
        playButton.anchor(top: nil, bottom: nil, left: nil, right: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 45, height: 45)
        playButton.centerYAnchor.constraint(equalTo: titleDisplayButton.centerYAnchor).isActive = true
        playButton.centerXAnchor.constraint(equalTo: titleDisplayButton.centerXAnchor).isActive = true

        
    }
    
    fileprivate func setupBottomToolbar() {
        
        let topDividerView = UIView()
        topDividerView.backgroundColor = .lightGray
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = .lightGray
        
        let stackView = UIStackView(arrangedSubviews: [imdbButton, wikiButton, rottenButton, commonButton, metaButton])
        stackView.distribution = .fillEqually
        addSubview(stackView)
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        stackView.anchor(top: nil, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 50)
        topDividerView.anchor(top: stackView.topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0.5)
        bottomDividerView.anchor(top: stackView.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

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
    
    
    var result: MovieResult? {
        didSet {
            guard let result = self.result else { return }
            guard let url = URL(string: result.poster400X570) else { return }
            titleImageView.kf.setImage(with:url)
            
            titleLabel.text = result.title + " " + "(\(result.releaseYear))"
            
        }
    }

    
    let titleImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
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
        label.text = "An unprecedented cinematic journey ten years in the making and spanning the entire Marvel Cinematic Universe, Marvel Studios' Avengers: Infinity War brings to the screen the ultimate, deadliest showdown of all time. The Avengers and their Super Hero allies must be willing to sacrifice all in an attempt to defeat the powerful Thanos before his blitz of devastation and ruin puts an end to the universe."
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
    
    @objc fileprivate func handleimdb() {
        guard let titleID = result?.imdb else { return }
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
        guard let titleID = result?.rottentomatoes else { return }
        print(titleID)
        let path = "https://www.rottentomatoes.com/m/" + "\(titleID)"
        print(path)
        guard let url = URL(string: path) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc fileprivate func handleCommon() {
        guard let path = result?.commonSenseMedia else { return }
        guard let url = URL(string: path) else { return }
        UIApplication.shared.open(url)
    }
    @objc fileprivate func handleMeta() {
        guard let path = result?.metacritic else { return }
        guard let url = URL(string: path) else { return }
        UIApplication.shared.open(url)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleImageView)
        addSubview(titleLabel)
        addSubview(titleDescription)
        
        titleImageView.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: nil, paddingTop: 12, paddingBottom: 0, paddingLeft: 12, paddingRight: 0, width: 80, height: 130)
        titleImageView.clipsToBounds = true
        
        setupBottomToolbar()
        
        titleLabel.anchor(top: nil, bottom: imdbButton.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 4, paddingBottom: 0, paddingLeft: 12, paddingRight: 12, width: 0, height: 50)
        
        //UIImageViewsetupUserStats()
        titleDescription.anchor(top: titleImageView.topAnchor, bottom: titleLabel.topAnchor, left: titleImageView.rightAnchor, right: self.rightAnchor, paddingTop: 4, paddingBottom: 0, paddingLeft: 8, paddingRight: 6, width: 0, height: 0)
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
    
//    fileprivate func setupUserStats() {
//        let stackView = UIStackView(arrangedSubviews: [postsLabel, followersLabel, followingLabel])
//        stackView.distribution = .fillEqually
//        addSubview(stackView)
//        stackView.anchor(top: topAnchor, bottom: nil, left: titleImageView.rightAnchor, right: rightAnchor, paddingTop: 12, paddingBottom: 0, paddingLeft: 12, paddingRight: 12, width: 0, height: 50)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

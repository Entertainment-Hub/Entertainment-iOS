//
//  SubscriptionShowFormat.swift
//  Entertainment Hub
//
//  Created by Michael Lema on 4/28/19.
//  Copyright © 2019 Michael Lema. All rights reserved.
//

import Foundation

struct SubscriptionShowFormat: Codable {
    let totalResults: Int
    let totalReturned: Int
    let results: [ShowResult]
    
    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case totalReturned = "total_returned"
        case results = "results"
    }
}

struct ShowResult: Codable {
    let id: Int
    let title: String
    let alternateTitles: [String]
    let containerShow: Int
    let firstAired: String
    let imdbID: String
    let tvdb: Int
    let themoviedb: Int
    let freebase: String?
    let wikipediaID: Int?
    let tvrage: TVrange
    let artwork208X117: String
    let artwork304X171: String
    let artwork448X252: String
    let artwork608X342: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case alternateTitles = "alternate_titles"
        case containerShow = "container_show"
        case firstAired = "first_aired"
        case imdbID = "imdb_id"
        case tvdb = "tvdb"
        case themoviedb = "themoviedb"
        case freebase = "freebase"
        case wikipediaID = "wikipedia_id"
        case tvrage = "tvrage"
        case artwork208X117 = "artwork_208x117"
        case artwork304X171 = "artwork_304x171"
        case artwork448X252 = "artwork_448x252"
        case artwork608X342 = "artwork_608x342"
    }
}

struct TVrange: Codable {
    let tvrageID: Int?
    let link: String?
    
    enum CodingKeys: String, CodingKey {
        case tvrageID = "tvrage_id"
        case link = "link"
    }
}

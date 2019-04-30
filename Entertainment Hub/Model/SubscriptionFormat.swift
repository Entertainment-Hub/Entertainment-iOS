//
//  Subscriptions.swift
//  Entertainment Hub
//
//  Created by Michael Lema on 2/23/19.
//  Copyright © 2019 Michael Lema. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let subscriptions = try? newJSONDecoder().decode(Subscriptions.self, from: jsonData)
import Foundation

struct SubscriptionFormat: Codable {
    let totalResults: Int
    let totalReturned: Int
    let results: [TitleResult]
    
    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case totalReturned = "total_returned"
        case results = "results"
    }
}

struct TitleResult: Codable {
    let id: Int
    let title: String
    let alternateTitles: [String]
    let containerShow: Int?
    let firstAired: String?
    let imdbID: String?
    let tvdb: Int?
    let themoviedb: Int
    let freebase: String?
    let wikipediaID: Int?
    let tvrage: SubTvrage?
    let artwork208X117: String?
    let artwork304X171: String?
    let artwork448X252: String?
    let artwork608X342: String?
    let releaseYear: Int?
    let originalTitle: String?
    let imdb: String?
    let preOrder: Bool?
    let inTheaters: Bool?
    let releaseDate: String?
    let rating: String?
    let rottentomatoes: Int?
    let metacritic: String?
    let commonSenseMedia: String?
    let poster120X171: String?
    let poster240X342: String?
    let poster400X570: String?
    
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
        case releaseYear = "release_year"
        case originalTitle = "original_title"
        case imdb = "imdb"
        case preOrder = "pre_order"
        case inTheaters = "in_theaters"
        case releaseDate = "release_date"
        case rating = "rating"
        case rottentomatoes = "rottentomatoes"
        case metacritic = "metacritic"
        case commonSenseMedia = "common_sense_media"
        case poster120X171 = "poster_120x171"
        case poster240X342 = "poster_240x342"
        case poster400X570 = "poster_400x570"
    }
}

struct SubTvrage: Codable {
    let tvrageID: Int?
    let link: String?
    
    enum CodingKeys: String, CodingKey {
        case tvrageID = "tvrage_id"
        case link = "link"
    }
}


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

struct Subscription: Codable {
    let totalResults: Int
    let totalReturned: Int
    let results: [MoviesResult]
    
    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case totalReturned = "total_returned"
        case results = "results"
    }
}

struct MoviesResult: Codable {
    let id: Int
    let title: String
    let releaseYear: Int
    let themoviedb: Int
    let originalTitle: String
    let alternateTitles: [String]
    let imdb: String
    let preOrder: Bool
    let inTheaters: Bool
    let releaseDate: String
    let rating: String
    let rottentomatoes: Int
    let freebase: String
    let wikipediaID: Int
    let metacritic: String?
    let commonSenseMedia: String?
    let poster120X171: String
    let poster240X342: String
    let poster400X570: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case releaseYear = "release_year"
        case themoviedb = "themoviedb"
        case originalTitle = "original_title"
        case alternateTitles = "alternate_titles"
        case imdb = "imdb"
        case preOrder = "pre_order"
        case inTheaters = "in_theaters"
        case releaseDate = "release_date"
        case rating = "rating"
        case rottentomatoes = "rottentomatoes"
        case freebase = "freebase"
        case wikipediaID = "wikipedia_id"
        case metacritic = "metacritic"
        case commonSenseMedia = "common_sense_media"
        case poster120X171 = "poster_120x171"
        case poster240X342 = "poster_240x342"
        case poster400X570 = "poster_400x570"
    }
}


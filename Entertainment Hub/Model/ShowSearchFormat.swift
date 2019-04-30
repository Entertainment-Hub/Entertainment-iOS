//
//  ShowSearchFormat.swift
//  Entertainment Hub
//
//  Created by Michael Lema on 4/29/19.
//  Copyright © 2019 Michael Lema. All rights reserved.
//

import Foundation

struct ShowSearchFormat: Codable {
    let totalResults: Int
    let results: [SearchResult]
    
    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case results = "results"
    }
}

struct SearchResult: Codable {
    let id: Int
    let title: String
    let alternateTitles: [String]
    let containerShow: Int?
    let firstAired: SubFirstAired?
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

enum SubFirstAired: Codable {
    case bool(Bool)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(SubFirstAired.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for SubFirstAired"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
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

//
//  MovieMetadata.swift
//  Entertainment Hub
//
//  Created by Michael Lema on 4/29/19.
//  Copyright © 2019 Michael Lema. All rights reserved.
//

import Foundation

struct MovieMetadata: Codable {
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
    let metacritic: String
    let commonSenseMedia: String
    let overview: String
    let poster120X171: String
    let poster240X342: String
    let poster400X570: String
    let social: SubSocial
    let genres: [SubGenre]
    let tags: [SubTag]
    let duration: Int
    let trailers: SubTrailers
    let writers: [SubDirector]
    let directors: [SubDirector]
    let cast: [SubCast]
    let freeWebSources: [JSONAny]
    let freeIosSources: [JSONAny]
    let freeAndroidSources: [JSONAny]
    let tvEverywhereWebSources: [JSONAny]
    let tvEverywhereIosSources: [JSONAny]
    let tvEverywhereAndroidSources: [JSONAny]
    let subscriptionWebSources: [SubscriptionWebSource]
    let subscriptionIosSources: [SubscriptionIosSource]
    let subscriptionAndroidSources: [SubscriptionAndroidSource]
    let purchaseWebSources: [SubPurchaseWebSource]
    let purchaseIosSources: [SubPurchaseIosSource]
    let purchaseAndroidSources: [SubPurchaseAndroidSource]
    let otherSources: SubOtherSourcesUnion
    
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
        case overview = "overview"
        case poster120X171 = "poster_120x171"
        case poster240X342 = "poster_240x342"
        case poster400X570 = "poster_400x570"
        case social = "social"
        case genres = "genres"
        case tags = "tags"
        case duration = "duration"
        case trailers = "trailers"
        case writers = "writers"
        case directors = "directors"
        case cast = "cast"
        case freeWebSources = "free_web_sources"
        case freeIosSources = "free_ios_sources"
        case freeAndroidSources = "free_android_sources"
        case tvEverywhereWebSources = "tv_everywhere_web_sources"
        case tvEverywhereIosSources = "tv_everywhere_ios_sources"
        case tvEverywhereAndroidSources = "tv_everywhere_android_sources"
        case subscriptionWebSources = "subscription_web_sources"
        case subscriptionIosSources = "subscription_ios_sources"
        case subscriptionAndroidSources = "subscription_android_sources"
        case purchaseWebSources = "purchase_web_sources"
        case purchaseIosSources = "purchase_ios_sources"
        case purchaseAndroidSources = "purchase_android_sources"
        case otherSources = "other_sources"
    }
}

struct SubCast: Codable {
    let id: Int
    let name: String
    let characterName: String
    let imdb: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case characterName = "character_name"
        case imdb = "imdb"
        case image = "image"
    }
}

struct SubDirector: Codable {
    let id: Int
    let name: String
    let imdb: String
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case imdb = "imdb"
        case image = "image"
    }
}

struct SubGenre: Codable {
    let id: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
    }
}

enum SubOtherSourcesUnion: Codable {
    case anythingArray([JSONAny])
    case subOtherSourcesClass(SubOtherSourcesClass)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([JSONAny].self) {
            self = .anythingArray(x)
            return
        }
        if let x = try? container.decode(SubOtherSourcesClass.self) {
            self = .subOtherSourcesClass(x)
            return
        }
        throw DecodingError.typeMismatch(SubOtherSourcesUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for SubOtherSourcesUnion"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .anythingArray(let x):
            try container.encode(x)
        case .subOtherSourcesClass(let x):
            try container.encode(x)
        }
    }
}

struct SubOtherSourcesClass: Codable {
    let movieTheater: [SubMovieTheater]
    
    enum CodingKeys: String, CodingKey {
        case movieTheater = "movie_theater"
    }
}

struct SubMovieTheater: Codable {
    let source: String
    let sourceType: String
    let displayName: String
    let link: String
    let platform: String
    
    enum CodingKeys: String, CodingKey {
        case source = "source"
        case sourceType = "source_type"
        case displayName = "display_name"
        case link = "link"
        case platform = "platform"
    }
}

struct SubPurchaseAndroidSource: Codable {
    let source: String
    let displayName: String
    let link: String
    let appName: String
    let appLink: Int
    let appRequired: Int
    let appDownloadLink: String
    let formats: [SubFormat]
    
    enum CodingKeys: String, CodingKey {
        case source = "source"
        case displayName = "display_name"
        case link = "link"
        case appName = "app_name"
        case appLink = "app_link"
        case appRequired = "app_required"
        case appDownloadLink = "app_download_link"
        case formats = "formats"
    }
}

struct SubFormat: Codable {
    let price: String
    let format: String
    let type: String
    let preOrder: Bool
    
    enum CodingKeys: String, CodingKey {
        case price = "price"
        case format = "format"
        case type = "type"
        case preOrder = "pre_order"
    }
}

struct SubPurchaseIosSource: Codable {
    let source: String
    let displayName: String
    let link: String
    let appName: String
    let appLink: Int
    let appRequired: Int
    let appDownloadLink: String
    let formats: [SubFormat]
    
    enum CodingKeys: String, CodingKey {
        case source = "source"
        case displayName = "display_name"
        case link = "link"
        case appName = "app_name"
        case appLink = "app_link"
        case appRequired = "app_required"
        case appDownloadLink = "app_download_link"
        case formats = "formats"
    }
}

struct SubPurchaseWebSource: Codable {
    let source: String
    let displayName: String
    let link: String
    let formats: [SubFormat]
    
    enum CodingKeys: String, CodingKey {
        case source = "source"
        case displayName = "display_name"
        case link = "link"
        case formats = "formats"
    }
}

struct SubSocial: Codable {
    let facebook: SubFacebook
    
    enum CodingKeys: String, CodingKey {
        case facebook = "facebook"
    }
}

struct SubFacebook: Codable {
    let facebookID: Int
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case facebookID = "facebook_id"
        case link = "link"
    }
}

struct SubscriptionAndroidSource: Codable {
    let source: String
    let displayName: String
    let link: String
    let appName: String
    let appLink: Int
    let appRequired: Int
    let appDownloadLink: String
    
    enum CodingKeys: String, CodingKey {
        case source = "source"
        case displayName = "display_name"
        case link = "link"
        case appName = "app_name"
        case appLink = "app_link"
        case appRequired = "app_required"
        case appDownloadLink = "app_download_link"
    }
}

struct SubscriptionIosSource: Codable {
    let source: String
    let displayName: String
    let link: String
    let appName: String
    let appLink: Int
    let appRequired: Int
    let appDownloadLink: String
    
    enum CodingKeys: String, CodingKey {
        case source = "source"
        case displayName = "display_name"
        case link = "link"
        case appName = "app_name"
        case appLink = "app_link"
        case appRequired = "app_required"
        case appDownloadLink = "app_download_link"
    }
}

struct SubscriptionWebSource: Codable {
    let source: String
    let displayName: String
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case source = "source"
        case displayName = "display_name"
        case link = "link"
    }
}

struct SubTag: Codable {
    let id: Int
    let tag: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case tag = "tag"
    }
}

struct SubTrailers: Codable {
    let web: [JSONAny]
    let ios: [JSONAny]
    let android: [JSONAny]
    
    enum CodingKeys: String, CodingKey {
        case web = "web"
        case ios = "ios"
        case android = "android"
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}

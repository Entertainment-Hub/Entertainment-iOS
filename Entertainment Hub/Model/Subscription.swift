//
//  Subscription.swift
//  Entertainment Hub
//
//  Created by Michael Lema on 2/23/19.
//  Copyright © 2019 Michael Lema. All rights reserved.
//

import Foundation


class Subscription {
    
    var subscriptionMovieResponse: SubscriptionMovieFormat?
    var subscriptionShowResponse: SubscriptionShowFormat?
    var showSearchFormat: ShowSearchFormat?

    init(from: SubscriptionName) {
        subscriptionMovieResponse = readMovieJSON(resource: from.rawValue)
        subscriptionShowResponse = readShowJSON(resource: from.path)
        
        /* Read the Search JSON if necessary */
        if from == .none {
            showSearchFormat = readShowSearchJSON()
        }
    }
    
    
    func allMovies() -> [MovieResult]? {
        guard let subscription = subscriptionMovieResponse else { return nil}
        return subscription.results
    }
    
    
    func allShows() -> [ShowResult]? {
        guard let showResponse = subscriptionShowResponse else { return nil}
        return showResponse.results
    }
    
    func allSearchShows() -> [SearchResult]? {
        guard let searchResponse = showSearchFormat else { return nil}
        return searchResponse.results
    }

    
    /* Movie JSON */
    private func readMovieJSON(resource: String) -> SubscriptionMovieFormat? {
        guard let fileURL = Bundle.main.url(forResource: resource, withExtension: "json") else {
            print("COULD NOT FIND FILE")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let jsonDecoder = JSONDecoder()
            let subscription =  try jsonDecoder.decode(SubscriptionMovieFormat.self, from: data)
            return subscription
            
        } catch { print(error.localizedDescription)}
        return nil
    }
    
    /* Show JSON */
    private func readShowJSON(resource: String) -> SubscriptionShowFormat? {
        guard let fileURL = Bundle.main.url(forResource: resource, withExtension: "json") else {
            print("COULD NOT FIND FILE")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let jsonDecoder = JSONDecoder()
            let subscription =  try jsonDecoder.decode(SubscriptionShowFormat.self, from: data)
            return subscription
            
        } catch { print(error.localizedDescription)}
        return nil
    }
    
    /* Show Search JSON */
    private func readShowSearchJSON(resource: String = "Sample Search") -> ShowSearchFormat? {
        guard let fileURL = Bundle.main.url(forResource: resource, withExtension: "json") else {
            print("COULD NOT FIND FILE")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let jsonDecoder = JSONDecoder()
            let showSearchFormat =  try jsonDecoder.decode(ShowSearchFormat.self, from: data)
            return showSearchFormat
            
        } catch { print(error.localizedDescription)}
        return nil
    }
}

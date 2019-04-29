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

    init(from: SubscriptionName) {
        subscriptionMovieResponse = readMovieJSON(resource: from.rawValue)
        subscriptionShowResponse = readShowJSON(resource: from.path)
    }
    
    
    func allMovies() -> [MovieResult]? {
        guard let subscription = subscriptionMovieResponse else { return nil}
        return subscription.results
    }
    
    
    func allShows() -> [ShowResult]? {
        guard let subscription = subscriptionShowResponse else { return nil}
        return subscription.results
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
}

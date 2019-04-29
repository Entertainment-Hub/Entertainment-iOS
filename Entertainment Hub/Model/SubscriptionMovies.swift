//
//  SubscriptionMovies.swift
//  Entertainment Hub
//
//  Created by Michael Lema on 2/23/19.
//  Copyright © 2019 Michael Lema. All rights reserved.
//

import Foundation


class SubscriptionMovies {
    
    var subscriptionService: Subscription?
    var serviceName = ""
    
    init(from: SubscriptionName) {
        subscriptionService = readJSON(resource: from.rawValue)
        serviceName = from.rawValue
    }
    
    
    func allMovies() -> [MoviesResult]? {
        guard let subscription = subscriptionService else { return nil}
        return subscription.results
    }
    
    
    
    private func readJSON(resource: String) -> Subscription? {
        guard let fileURL = Bundle.main.url(forResource: resource, withExtension: "json") else {
            print("COULD NOT FIND FILE")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let jsonDecoder = JSONDecoder()
            let subscription =  try jsonDecoder.decode(Subscription.self, from: data)
            return subscription
            
        } catch { print(error.localizedDescription) }
        return nil
    }
}

////
////  SubscriptionMovies.swift
////  Entertainment Hub
////
////  Created by Michael Lema on 2/23/19.
////  Copyright © 2019 Michael Lema. All rights reserved.
////
//
//import Foundation
//
//class GuideBoxMovies {
//    
//    typealias QueryResult = ([MoviesResult]?, String) -> ()
//    var subscription: Subscription?
//    var serviceName = ""
//    
//    init(from: SubscriptionName) {
//        
//        //subscription = readJSON(resource: from.rawValue)
//        subscription = requestMovies(resource:from)
//    }
//    
//    
//    func allMovies() -> [MoviesResult]? {
//        guard let subscription = subscription else { return nil}
//        return subscription.results
//    }
//    
//    
//    
//    private func requestMovies(resource: SubscriptionName, completion: @escaping QueryResult) -> Subscription? {
//        let movie = GuideBox.movies(resource)
//        guard let url = movie.components.url else { return nil}
//
//        
//        var subscription: Subscription?
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data, error == nil else { return }
//            do {
//                let jsonDecoder = JSONDecoder()
//                subscription =  try jsonDecoder.decode(Subscription.self, from: data)
//                //return subscription
//                
//            } catch let error as NSError {
//                print("error \(error.localizedDescription)")
//                subscription = nil
//            }
//            }.resume()
//        
//        return subscription
//
//    }
//    
//    
//    /* This reads the JSON Files. No longer needed. */
//    private func readJSON(resource: String) -> Subscription? {
//        guard let fileURL = Bundle.main.url(forResource: resource, withExtension: "json") else {
//            print("COULD NOT FIND FILE")
//            return nil
//        }
//        
//        do {
//            let data = try Data(contentsOf: fileURL)
//            let jsonDecoder = JSONDecoder()
//            let subscription =  try jsonDecoder.decode(Subscription.self, from: data)
//            return subscription
//            
//        } catch { print(error.localizedDescription) }
//        return nil
//    }
//}

//
//  GuideBox.swift
//  Entertainment Hub
//
//  Created by Michael Lema on 4/28/19.
//  Copyright © 2019 Michael Lema. All rights reserved.
//

import Foundation

enum GuideBox {
    case movies(SubscriptionName)
    case shows(SubscriptionName)
}

protocol Path {
    var path : String { get }
    var source: String {get}
}

extension GuideBox : Path {
    var path: String {
        switch self {
        case .movies: return "/v2/movies"
        case .shows: return "/v2/shows"
        }
    }
    
    fileprivate func service(name: String) -> String {
        switch name {
        case "Netflix":
            return "netflix"
        case "Amazon Prime":
            return"amazon_prime"
        case "Hulu":
            return"hulu_plus"
        case "itunes":
            return"itunes"
        default:
            return ""
        }
    }
    
    var source: String {
        switch self {
        case .movies(let subscriptionName): return service(name: subscriptionName.rawValue)
        case .shows(let subscriptionName): return service(name: subscriptionName.rawValue)

        }
    }
}

protocol Moya: Path {
    var scheme: String {get}
    var host: String {get}
    var apiKey: String {get}
    
    var components: URLComponents {get}
    func get(completion: @escaping (_ annotations: [MoviesResult], _ error: Error?) -> Void)
}

extension GuideBox: Moya {
    var host: String {
        return "api-public.guidebox.com"
    }
    
    var scheme: String {
        return "http"
    }
    
    var apiKey: String {
        guard let filePath = Bundle.main.path(forResource: "Configuration", ofType: "plist") else { return "no" }
        guard let plist = NSDictionary(contentsOfFile: filePath) else {return "no"}
        return plist.object(forKey: "Guidebox API Key") as! String
    }
    
    var components: URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = self.path
        
        components.queryItems =  [
            URLQueryItem(name: "api_key", value: self.apiKey),
            URLQueryItem(name: "sources", value: "\(self.source)")
        ]
        return components
    }
    
    
    func get(completion: @escaping (_ annotations: [MoviesResult], _ error: Error?) -> Void) {
        guard let url = self.components.url else { return  }
        print("---")
        print(url)
        print("---")
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let decoder = JSONDecoder()
                let subscription = try decoder.decode(Subscription.self, from: data)
                completion(subscription.results, nil)
        
            } catch let error as NSError {
                completion([], error)
            }
            }.resume()
    }
}

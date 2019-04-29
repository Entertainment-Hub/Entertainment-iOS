//
//  SubscriptionService.swift
//  Entertainment Hub
//
//  Created by Michael Lema on 4/28/19.
//  Copyright © 2019 Michael Lema. All rights reserved.
//

import Foundation


enum SubscriptionName: String {
    case netflix = "Netflix"
    case amazonPrime = "Amazon Prime"
    case hulu = "Hulu"
    case itunes = "iTunes"
    case none = ""

}

protocol ShowPath {
    var path : String { get }
}

extension SubscriptionName : ShowPath {
    var path: String {
        switch self {
      default:
            return self.rawValue + " Shows"
        }
    }
}

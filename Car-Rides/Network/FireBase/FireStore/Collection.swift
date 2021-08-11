//
//  Collection.swift
//  Car-Rides
//
//  Created by Decagon on 7/30/21.

import Foundation

enum Collection {
    case users
    case userProfile
    case userTrips
    case userMessages
    
    var identifier: String {
        switch self {
        case .users :
            return "users"
        case .userProfile:
            return "user_profile"
        case .userTrips:
            return "user_trips"
        case .userMessages:
            return "user_messages"
        }
    }
}

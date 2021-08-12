//
//  TripsService.swift
//  Car-Rides
//
//  Created by Decagon on 8/12/21.
//

import Foundation

import Foundation
struct TripsService {
    let router = Router<TripsApi>()
    
    func getTrips(completion: @escaping NetworkRouterCompletion) {
        router.request(.getTrips, completion: completion)
    }
    
    func createTrips(with trip: Trip ,completion: @escaping NetworkRouterCompletion) {
        router.request(.createTrips(items: trip), completion: completion)
    }
}

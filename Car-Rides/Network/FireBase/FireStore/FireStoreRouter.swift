//
//  FireStoreRouter.swift
//  Car-Rides
//
//  Created by Decagon on 7/30/21.
//

import Foundation
protocol FireBaseRouter {
    associatedtype Endpoint: FirestoreRequest
    func request(_ request: Endpoint, completion: @escaping NetworkRouterCompletion)
}


//
//  YourTripsViewModel.swift
//  Car-Rides
//
//  Created by Decagon on 7/29/21.
//

import Foundation
class TripsViewModel {
    var tripsArray: [TripsModel] = []
    var notifyCompletion: (() -> Void)?
    
    func get() {
        self.tripsArray.removeAll()
        let getTrips = TripsService()
        getTrips.getTrips {(result) in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(let result):
                result?.documents.forEach({ (doc) in
                    let data = doc.data()
                    if let destination = data["destination"] as? String, let time = data["date"] as? String,
                       let price = data["price"] as? String {
                        let trip = TripsModel(price: price, title: destination, descriptionTag: time)
                        self.tripsArray.append(trip)
                    }
                })
                self.notifyCompletion?()
            }
        }
    }
}


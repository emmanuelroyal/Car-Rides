//
//  DirectionModel.swift
//  Car-Rides
//
//  Created by Decagon on 8/7/21.
//
import Foundation
import CoreLocation
import Alamofire



struct Location{
    let title: String
    let coordinates: CLLocationCoordinate2D
    
}

class LocationManager: NSObject {
    static let shared = LocationManager()
    
    func getLocations(with: String, completion: @escaping (([Location]) -> Void)){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(with){ places, error in
            guard let places = places, error == nil else  {
                completion([])
                return
            }
            let model:[Location] = places.compactMap({ place in
                var name = ""
                
                if let placeName = place.name {
                    name += placeName
                }
                if let adminArea = place.administrativeArea {
                    name += ", \(adminArea)"
                }
                if let locale = place.locality {
                    name += ", \(locale)"
                }
                if let country = place.country {
                    name += ", \(country)"
                }
                let results = Location(title: name, coordinates: place.location!.coordinate)
               return results
            })
            
            completion(model)
            
        }
    }
    
    
}

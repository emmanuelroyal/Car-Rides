//
//  CashViewController.swift
//  Car-Rides
//
//  Created by Decagon on 7/29/21.
//

import UIKit
import MapKit
import FABButton

class CashViewController: UIViewController, CLLocationManagerDelegate, FABSecondaryButtonDelegate {
    func secondaryActionForButton(_ action: @escaping () -> ()) {
        <#code#>
    }
    
    @IBOutlet weak var map: MKMapView!
    
    private let locationManager = CLLocationManager()
    private let mapTypeButton = FABView(buttonImage: UIImage(named: "earth"))
    

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapTypeButton()

      
    }
    private func configureMapTypeButton() {
        mapTypeButton.delegate = self
     
        mapTypeButton.addSecondaryButtonWith(image: UIImage(named: "map")!, labelTitle: "Standard", action: {
            self.map.mapType = .mutedStandard
        })
            
       mapTypeButton.addSecondaryButtonWith(image: UIImage(named: "satellite")!, labelTitle: "Satellite", action: {
           self.map.mapType = .satellite
       })
            
       mapTypeButton.addSecondaryButtonWith(image: UIImage(named: "hybrid")!, labelTitle: "Hybrid", action: {
           self.map.mapType = .hybrid
       })
            
       mapTypeButton.setFABButton()
    }
    
    private func checkLocationServices() {
        guard CLLocationManager.locationServicesEnabled() else {
            // Here we must tell user how to turn on location on device
            return
        }
            
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkAuthorizationForLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorizationForLocation()
       }
       
       
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
                let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate,
                                                               latitudinalMeters: rangeInMeters,
                                                               longitudinalMeters: rangeInMeters)
                
            map.setRegion(coordinateRegion, animated: true)
          
       }
    
    private func checkAuthorizationForLocation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            map.showsUserLocation = true
            centerViewOnUser()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Here we must tell user how to turn on location on device
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
                // Here we must tell user that the app is not authorize to use location services
            break
        @unknown default:
            break
        }
    }
    
    private let rangeInMeters: Double = 10000

    private func centerViewOnUser() {
        guard let location = locationManager.location?.coordinate else { return }
        
        let coordinateRegion = MKCoordinateRegion.init(center: location,
                                                       latitudinalMeters: rangeInMeters,
                                                       longitudinalMeters: rangeInMeters)
        map.setRegion(coordinateRegion, animated: true)
    }
    private let pointer = UIImageView(image: UIImage(systemName: "mappin"))
    private func layoutUI() {
        view.addSubview(mapTypeButton)
        pointer.translatesAutoresizingMaskIntoConstraints = false
        pointer.tintColor = .red
        view.addSubview(pointer)
        
        NSLayoutConstraint.activate([
            mapTypeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            mapTypeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            pointer.centerYAnchor.constraint(equalTo: map.centerYAnchor, constant: -14.5),
            pointer.centerXAnchor.constraint(equalTo: map.centerXAnchor),
            pointer.widthAnchor.constraint(equalToConstant: 27),
            pointer.heightAnchor.constraint(equalToConstant: 29)
       ])
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let coordinates = mapView.centerCoordinate
        return CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
    

    
    

}

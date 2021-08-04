//
//  CashViewController.swift
//  Car-Rides
//
//  Created by Decagon on 7/29/21.
//

    
import UIKit
import MapKit
import FABButton
import CoreLocation

class CashViewController: UIViewController, FABSecondaryButtonDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    private let locationManager = CLLocationManager()
    
    private let mapTypeButton = FABView(buttonImage: UIImage(systemName: "heart"))

    func secondaryActionForButton(_ action: @escaping () -> ()) {
        action()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapTypeButton()
        layoutUI()
        checkLocationServices()
        mapView.delegate = self
        
    }
    
    @IBAction func startButton(_ sender: Any) {
        drawRoutes()
    }
    
private func configureMapTypeButton() {
    mapTypeButton.delegate = self
 
    mapTypeButton.addSecondaryButtonWith(image: UIImage(systemName: "map")!, labelTitle: "Standard", action: {
        self.mapView.mapType = .mutedStandard
    })
        
   mapTypeButton.addSecondaryButtonWith(image: UIImage(systemName: "safari")!, labelTitle: "Satellite", action: {
       self.mapView.mapType = .satellite
   })
        
   mapTypeButton.addSecondaryButtonWith(image: UIImage(systemName: "ticket")!, labelTitle: "Hybrid", action: {
       self.mapView.mapType = .hybrid
   })
        
   mapTypeButton.setFABButton()
}

private func checkLocationServices() {
    guard CLLocationManager.locationServicesEnabled() else {
       print("no")
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
    let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let coordinateRegion = MKCoordinateRegion.init(center: center,
                                                           latitudinalMeters: rangeInMeters,
                                                           longitudinalMeters: rangeInMeters)
            
        mapView.setRegion(coordinateRegion, animated: true)
      
   }

private func checkAuthorizationForLocation() {
    switch CLLocationManager.authorizationStatus() {
    case .authorizedWhenInUse, .authorizedAlways:
        mapView.showsUserLocation = true
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
    mapView.setRegion(coordinateRegion, animated: true)
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
        pointer.centerYAnchor.constraint(equalTo: mapView.centerYAnchor, constant: -14.5),
        pointer.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
        pointer.widthAnchor.constraint(equalToConstant: 27),
        pointer.heightAnchor.constraint(equalToConstant: 29)
   ])
}

func getCenterLocation(for mapView: MKMapView) -> CLLocation {
    let coordinates = mapView.centerCoordinate
    return CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
}
    private let geoCoder = CLGeocoder()
    private var previousLocation: CLLocation?
    
    
    typealias CLGeocodeCompletionHandler = ([CLPlacemark]?, Error?) -> Void
    func createRequest() -> MKDirections.Request? {
        guard let coordinate = locationManager.location?.coordinate else { return nil }
        let destinationCoordinate = getCenterLocation(for: mapView).coordinate
        let origin = MKPlacemark(coordinate: coordinate)
        let destination = MKPlacemark(coordinate: destinationCoordinate)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: origin)
        request.destination = MKMapItem(placemark: destination)
        request.transportType = .automobile
            
        return request
    }
    func drawRoutes() {
        guard let request = createRequest() else { return }
        let directions = MKDirections(request: request)
            
        directions.calculate { [unowned self] (response, error) in
            guard let response = response else { return }
            let routes = response.routes
            for route in routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
//                self.addressLabel.text =  String(route.distance) +  String((route.expectedTravelTime)/60)
            }
        }
    }
    typealias DirectionsHandler = (MKDirections.Response?, Error?) -> Void
    
}

    extension CashViewController: MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
                let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
                renderer.strokeColor = .green
                renderer.lineWidth = 5
                return renderer
            }

        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            let center = getCenterLocation(for: mapView)
            
            guard let previousLocation = self.previousLocation,
                center.distance(from: previousLocation) > 25 else { return }
            
            self.previousLocation = center
            
            geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
                guard let self = self else { return }
                
                if let _ = error { // Show alert for the user
                    return
                }
                
                guard let placemark = placemarks?.first else { // Show alert for the user
                    return
                }
                
                let streetNumber = placemark.thoroughfare ?? ""
                let streetName = placemark.name ?? ""
                
                DispatchQueue.main.async {
//                    self.addressLabel.text = "\(streetNumber) \(streetName)"
                }
            }
        }
    }



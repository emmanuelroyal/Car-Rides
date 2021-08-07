//
//  HomePageViewController.swift
//  Car-Rides
//
//  Created by Decagon on 7/29/21.
//

import UIKit
import MapKit
import SideMenu
import GoogleMaps

class HomePageViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var mapView: GMSMapView!
    var menu: SideMenuNavigationController?
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        else {
            locationManager.requestWhenInUseAuthorization()
        }
        menu = SideMenuNavigationController(rootViewController: TableViewController())
        menu?.setNavigationBarHidden(true, animated: false)
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)

        
    }
    
    @IBAction func menuBtnPressed(_ sender: Any) {
        present(menu!, animated: true)
        
        
    }
    @IBAction func EnterPickUpPressed(_ sender: Any) {
        navigateToSearch()
    }
    
    @IBAction func chooseAsavedPlace(_ sender: Any) {
        navigateToSearch()
    }
    
    @IBAction func setDestinationPressed(_ sender: Any) {
        navigateToSearch()
    }
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            return
        case .denied:
            // Show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
       }
       
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapView.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0 , longitude: locationManager.location?.coordinate.longitude ?? 0.0), zoom: 8, bearing: 0, viewingAngle: 0)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0 , longitude: locationManager.location?.coordinate.longitude ?? 0.0)
        marker.title = "Yes"
        marker.snippet = "Win"
        marker.iconView?.bounds.size = CGSize(width: 20, height: 20)
        marker.icon = UIImage(systemName: "person.crop.circle")
        marker.map = mapView
        let sourceLat = locationManager.location!.coordinate.latitude
        let sourceLon = locationManager.location!.coordinate.longitude
        
       }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("ERROR")
    }
    
    
}

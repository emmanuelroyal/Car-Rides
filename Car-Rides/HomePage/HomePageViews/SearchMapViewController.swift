//
//  SearchMapViewController.swift
//  Car-Rides
//
//  Created by Decagon on 8/7/21.
//

import UIKit
import CoreLocation
import GoogleMaps
import Alamofire
import SwiftyJSON

class SearchMapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    var routes = [Request]()
    
    var location = [Location]()
    var sourceLat = 0.0
    var sourceLon = 0.0
    var destLat = 0.0
    var destLon = 0.0
    var destMarker = ""
    var distance = ""
    var duration = ""
    var destination = ""
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.isHidden = true
        searchBar.delegate = self
        locationManager.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        location.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  table.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.frame = CGRect(x: 20, y:20 , width: Int(view.frame.width), height: 100)
        cell.textLabel?.text = location[indexPath.row].title
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        table.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.destination = searchBar.text!
        table.isHidden = false
        if let text = searchBar.text, !text.isEmpty {
            LocationManager.shared.getLocations(with: text) {
                [weak self] locations in
                DispatchQueue.main.async {
                    self?.location = locations
                    self?.table.reloadData()
                }
                
            }
        }
        
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
        mapView.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0 , longitude: locationManager.location?.coordinate.longitude ?? 0.0), zoom: 10, bearing: 0, viewingAngle: 0)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0 , longitude: locationManager.location?.coordinate.longitude ?? 0.0)
        marker.title = "Yes"
        marker.snippet = "Win"
        marker.iconView?.bounds.size = CGSize(width: 20, height: 20)
        marker.icon = UIImage(systemName: "person.crop.circle")
        marker.map = mapView
        let sourceLat = locationManager.location!.coordinate.latitude
        let sourceLon = locationManager.location!.coordinate.longitude
        self.sourceLat = sourceLat
        self.sourceLon = sourceLon
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("ERROR")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.destLon = location[indexPath.row].coordinates.longitude
        self.destLat = location[indexPath.row].coordinates.latitude
        self.destMarker = location[indexPath.row].title
        table.isHidden = true
        mapView.clear()
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: destLat , longitude: destLon )
        marker.title = "Yes"
        marker.snippet = "Win"
        marker.map = mapView
        print(self.sourceLon, self.sourceLat, self.destLon, self.destLat, self.destMarker)
        let markers = GMSMarker()
        markers.position = CLLocationCoordinate2D(latitude: sourceLat , longitude: sourceLon )
        markers.title = "Yes"
        markers.snippet = "Win"
        markers.iconView?.bounds.size = CGSize(width: 20, height: 20)
        markers.icon = UIImage(systemName: "person.crop.circle")
        markers.map = mapView
        
        let url =  "https://maps.googleapis.com/maps/api/directions/json?origin=\(sourceLat),\(sourceLon)&destination=\(destLat),\(destLon)&key=AIzaSyBf5Atsf8AXFvPwh9BrExCYKS5RC10ERCA"
        
        AF.request(url).responseJSON { response in
            guard let data = response.data else { return }
            
            do
            {
                let jsonData = try JSON(data: data)
                let routes = jsonData["routes"].arrayValue
                print(jsonData)
                for route in routes {
                    let overView = route["overview_polyline"].dictionary
                    let points = overView?["points"]?.string
                    let path = GMSPath.init(fromEncodedPath: points ?? "")
                    let polyline = GMSPolyline.init(path: path)
                    polyline.strokeWidth = 6
                    polyline.strokeColor = .systemBlue
                    polyline.map = self.mapView
                    
                }
            }
            catch let error {
                print(error.localizedDescription)
            }
            
            var routeJson: Request?
            do {
                routeJson = try JSONDecoder().decode(Request.self, from: data)
            } catch {
                debugPrint(error)
            }
            guard let route = routeJson else { return }
            self.routes.removeAll()
            self.routes.append(route)
            if self.routes[0].status == "OK" {
                let pmi = route.routes[0].legs[0].distance.text
                let dmi = route.routes[0].legs[0].duration.text
                let time = route.routes[0].legs[0].duration.value
                DispatchQueue.main.async {
                    self.distanceLbl.text = "distance: \(pmi)"
                    self.durationLabel.text = "duration: \(dmi)"
                    self.priceLbl.text = "\(Int((Double(time) * 0.8) + 250)) Naira"
                }
            }
            else {
                self.distanceLbl.text = "Invalid address"
                self.durationLabel.text = ""
                self.priceLbl.text = ""
            }
        }
        
        print(self.duration, self.distance, "here")
        let camera = GMSCameraPosition(target: marker.position, zoom: 10)
        mapView.animate(to: camera)
    }
    
    @IBAction func reqPressed(_ sender: Any) {
        if self.destination != "" && self.priceLbl.text
         != nil {
        HUD.show(status: "Requesting trip...")
        var trip = Trip()
        trip.Destination = self.destination
        trip.date = "\(getCurrentTime())"
        trip.price = "\(priceLbl.text!)"
        
        let request = TripsService()
        request.createTrips(with: trip) { (result) in
            switch result {
            case .success:
                HUD.hide()
                let alertController =
                    UIAlertController(title: "Done",
                                      message: "Trip successfully requested your driver will contact you soon!", preferredStyle: .alert)
                let acceptAction = UIAlertAction(title: "Accept", style: .default) { (_) -> Void in
                    self.navigateToHome()
                }
                alertController.addAction(acceptAction)
                self.present(alertController, animated: true, completion: nil)
            case .failure(_):
                HUD.hide()
                self.showAlert(alertText: "Error",
    alertMessage: "There was an error requesting trip, please try again.")
                
            }
        }
        }
    }
    
    @IBAction func backPressed(_ sender: Any) {
        navigateToHome()
    }
}

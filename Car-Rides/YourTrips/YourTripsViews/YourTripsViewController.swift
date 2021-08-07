//
//  YourTripsViewController.swift
//  Car-Rides
//
//  Created by Decagon on 7/29/21.
//

import UIKit

class YourTripsViewController: UIViewController {
    
    @IBOutlet weak var tripsTable: UITableView!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigateToHome()
    }
    
    @IBAction func pastPressed(_ sender: Any) {
    }
}

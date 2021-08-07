//
//  SettingsViewController.swift
//  Car-Rides
//
//  Created by Decagon on 7/29/21.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var personalDetailsTable: UITableView!
    @IBOutlet weak var favouritesTable: UITableView!
    @IBOutlet weak var safetyTable: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func backPressed(_ sender: Any) {
        navigateToHome()
    }
    
    @IBAction func morePlacesPressed(_ sender: Any) {
    }
    
    @IBAction func signOutPressed(_ sender: Any) {
        HUD.show(status: "Logging out...")
        do {
            try Auth.auth().signOut()
        } catch {
            self.showAlert(alertText: "Error",
                           alertMessage: "There was an error logging you out. Please try again.")
        }
        HUD.hide()
       navigateToLoginPage()
    }
}

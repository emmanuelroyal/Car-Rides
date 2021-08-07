//
//  WalletViewController.swift
//  Car-Rides
//
//  Created by Decagon on 7/29/21.
//

import UIKit

class WalletViewController: UIViewController {
    
    @IBOutlet weak var paymentMethodTable: UITableView!
    
    @IBOutlet weak var tripProfileTable: UITableView!
    
    @IBOutlet weak var voucherTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        navigateToHome()
    }
    
    @IBAction func openCashPressed(_ sender: Any) {
    }
    
    @IBAction func addPromoPressed(_ sender: Any) {
    }
}

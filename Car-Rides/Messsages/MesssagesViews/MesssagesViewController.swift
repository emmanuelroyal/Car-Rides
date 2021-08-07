//
//  MesssagesViewController.swift
//  Car-Rides
//
//  Created by Decagon on 7/29/21.
//

import UIKit

class MesssagesViewController: UIViewController {
    @IBOutlet weak var messageTable: UITableView!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var label1: UILabel!
    
    
    @IBOutlet weak var label2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    

  
    @IBAction func backButtonPressed(_ sender: Any) {
        navigateToHome()
    }
    
}

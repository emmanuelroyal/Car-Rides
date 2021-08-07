//
//  HelpViewController.swift
//  Car-Rides
//
//  Created by Decagon on 7/29/21.
//

import UIKit

class HelpViewController: UIViewController {
    
    @IBOutlet weak var helpTable: UITableView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backPressed(_ sender: Any) {
        navigateToHome()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

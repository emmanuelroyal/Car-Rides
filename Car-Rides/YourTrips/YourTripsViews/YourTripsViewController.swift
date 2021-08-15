//
//  YourTripsViewController.swift
//  Car-Rides
//
//  Created by Decagon on 7/29/21.
//

import UIKit

class YourTripsViewController: UIViewController {
    
    @IBOutlet weak var tripsTable: UITableView!
    var viewModel = TripsViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.get()
        
        viewModel.notifyCompletion = { [weak self] in
            DispatchQueue.main.async {
                self?.tripsTable.reloadData()
            }
            
        }

       
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigateToHome()
    }
    
    @IBAction func pastPressed(_ sender: Any) {
    }
}
extension YourTripsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tripsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tripsTable.dequeueReusableCell(withIdentifier: "trips", for: indexPath) as? TripsTableViewCell else { return UITableViewCell() }
        cell.configure(with: viewModel.tripsArray[indexPath.row])
        return cell
    }
    
    
    
    
    
}

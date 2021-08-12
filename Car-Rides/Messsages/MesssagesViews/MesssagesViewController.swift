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
    var viewModel = MessagesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.get()
        messageTable.register(UINib(nibName: MessagesTableViewCell.identifier,
                                                   bundle: nil),
                                             forCellReuseIdentifier: MessagesTableViewCell.identifier)
        viewModel.notifyCompletion = {
            DispatchQueue.main.async {
                self.messageTable.reloadData()
            }
        }
     
    }
    

  
    @IBAction func backButtonPressed(_ sender: Any) {
        navigateToHome()
    }
    
}

extension MesssagesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = messageTable.dequeueReusableCell(withIdentifier: MessagesTableViewCell.identifier,
                                     for: indexPath) as? MessagesTableViewCell else {
                    return UITableViewCell()
                }
        cell.setup(with: viewModel.messageArray[indexPath.row])
        
        return cell
    }
}

extension MesssagesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

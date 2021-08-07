//
//  TableViewController.swift
//  Car-Rides
//
//  Created by Decagon on 8/6/21.
//

import UIKit

class TableViewController: UITableViewController {
var viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cells")
    }

    var vc: [UIViewController] = [MesssagesViewController(), YourTripsViewController()]

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = viewModel.items[indexPath.row].name
        cell.textLabel?.textColor = .white
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 {
            cell.backgroundColor = .darkGray
            cell.textLabel?.textColor = .white
        }
        else {
            cell.backgroundColor = .white
            cell.textLabel?.textColor = .darkGray
        }
        if indexPath.row == 1 || indexPath.row == 2 {
            cell.isUserInteractionEnabled = false
            
        }
        
        return cell
    }
    
   override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let head = UIView(frame: CGRect(x: 80,
                                        y: 80, width: view.frame.size.width, height: 80))
        guard let cell = tableView
                .dequeueReusableCell(withIdentifier: "cells")
    
else {            return UIView()
        }
    cell.textLabel?.text = "win"
    cell.backgroundColor = .darkGray
    cell.textLabel?.textColor = .white
    
    cell.frame = CGRect(x: 100, y: 100, width: view.frame.size.width, height: 80)
    cell.imageView?.tintColor = .black
    cell.imageView?.cornerRadius = 60
    cell.imageView?.image = #imageLiteral(resourceName: "IMG_0626")

        self.tableView.tableHeaderView = cell
    head.backgroundColor = .darkGray
        return head
    }
    
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            let newStoryboard = UIStoryboard(name: viewModel.items[indexPath.row].storyboardName , bundle: nil)
            let newController = newStoryboard
                .instantiateViewController(identifier: viewModel.items[indexPath.row].storyBoard) as UIViewController
            newController.modalTransitionStyle = .crossDissolve
            newController.modalPresentationStyle = .fullScreen
            present(newController, animated: true, completion: nil)
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



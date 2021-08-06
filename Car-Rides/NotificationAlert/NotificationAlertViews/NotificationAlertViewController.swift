//
//  NotificationAlertViewController.swift
//  Car-Rides
//
//  Created by Decagon on 7/29/21.
//

import UIKit

class NotificationAlertViewController: UIViewController {
    @IBOutlet weak var guidelines: UIStackView!
    @IBOutlet weak var welcomelbl: UITextField!
    @IBOutlet weak var peopleImage: UIImageView!
    @IBOutlet weak var customise: UITextField!
    
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var image3: UIImageView!
    
    @IBOutlet weak var image4: UIImageView!
    var timer: Timer?
    var value = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        createTimer()
        guidelines.isHidden = true
        self.image1.isHidden = true
        self.image2.isHidden = true
        self.image3.isHidden = true
        self.image4.isHidden = true
        
    }
    
    @objc func toggle() {
        if value == 1 || value == 5  {
            self.image1.isHidden = false
            self.image2.isHidden = true
            self.image3.isHidden = true
            self.image4.isHidden = true
            toggles()
        } else if value == 2 || value == 6  {
            self.image1.isHidden = true
            self.image2.isHidden = false
            self.image3.isHidden = true
            self.image4.isHidden = true
            toggles()
        }
        else if value == 3 || value == 7  {
            self.image1.isHidden = true
            self.image2.isHidden = true
            self.image3.isHidden = false
            self.image4.isHidden = true
            toggles()
        }
        else if value == 4 {
            self.image1.isHidden = true
            self.image2.isHidden = true
            self.image3.isHidden = true
            self.image4.isHidden = false
            toggles()
        }
        else if value == 8 {
            self.image1.isHidden = true
            self.image2.isHidden = true
            self.image3.isHidden = true
            self.image4.isHidden = false
            show()
        }
        
        
        
        
    }
    @objc func toggles(){
        DispatchQueue.main.async { [self] in
            perform(#selector(createTimer), with: nil, afterDelay: 0.25)
        }
    }
    @objc func createTimer() {
        self.value += 1
        timer = Timer.scheduledTimer(timeInterval: 0.25,
                                     target: self,
                                     selector: #selector(toggle),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    func show() {
        self.guidelines.isHidden = false
        self.image1.isHidden = true
        self.image2.isHidden = true
        self.image3.isHidden = true
        self.image4.isHidden = true
        self.welcomelbl.isHidden = true
        self.customise.isHidden = true
        
    }
    
    @IBAction func backPressed(_ sender: Any) {
    }
    
    @IBAction func understandPressed(_ sender: Any) {
      navigateToHome()
        
        
        
    }
    
    
}

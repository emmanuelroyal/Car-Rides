//
//  ProfileRegistrationViewController.swift
//  Car-Rides
//
//  Created by Decagon on 7/29/21.
//

import UIKit

class ProfileRegistrationViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    var viewModel = LoginViewModel()
    
    @IBOutlet weak var secureButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func eyePressed(_ sender: Any) {
        viewModel.toggle(passField: password, secureButton: secureButton)
        
    }
    
    @IBAction func SighInPressed(_ sender: Any) {
        if let email = email.text, let pass = password.text {
            
            if email.isEmpty == true ||  pass.isEmpty == true {
                self.showAlert(alertText: "Incomplete details", alertMessage: "Please, enter your email and password.")
            }
            else {
                HUD.show(status: "Welcome Back")
                viewModel.loginUser(with: email, password: pass) { [weak self] success in
                    HUD.hide()
                    success ? self?.navigateToWelcome() : self?
                        .showAlert(alertText: "OOPS...Incorrect Details",
                                   alertMessage: "Incorrect email or password. Please check your details and try again.")
                }
            }
        }
        
        
    }
    
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        
    }
    
    @IBAction func socialButtonPressed(_ sender: Any) {
        navigateToSignUp()
    }
    
}

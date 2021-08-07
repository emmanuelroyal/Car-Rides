//
//  TermsOfServiceViewController.swift
//  Car-Rides
//
//  Created by Decagon on 7/29/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class TermsOfServiceViewController: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    var viewModel = SignupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        if  viewModel.validateTextField(inView: self, fullName: firstName.text!, email: email.text!, password: password.text!) == true {
        if email.text?.isEmpty == false && firstName.text?.isEmpty == false && password.text?.isEmpty == false {
            HUD.show(status: "Signing you in")
            if let email = email.text, let password = password.text, let fullName = firstName.text {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let error = error, authResult != nil {
                        print(error.localizedDescription)
                        HUD.hide()
                    } else {
                        let docId = Auth.auth().currentUser?.uid
                        Firestore.firestore().collection("users").document(docId!).setData(
                            ["email": email, "fullName": fullName, "photo": "" ]) { (error) in
                            if error != nil {
                                HUD.hide()
                                self.showAlert(alertText: "Error",
                                               alertMessage: "There was an error creating account, please try again.")
                            } else {
                                HUD.hide()
                                let alertController =
                                    UIAlertController(title: "Done",
                                                      message: "Account created successfully!", preferredStyle: .alert)
                                let acceptAction = UIAlertAction(title: "Accept", style: .default) { (_) -> Void in
                                    self.navigateToWelcome()
                                }
                                alertController.addAction(acceptAction)
                                self.present(alertController, animated: true, completion: nil)
                                
                            }
                        }
                    }
                }
            }
        }
        else {
            return
             }
        }
        else {
            return
        }
    }
        
    
    @IBAction func connectWithSocialMedia(_ sender: Any) {
       navigateToLoginPage()
        
    }
    
}

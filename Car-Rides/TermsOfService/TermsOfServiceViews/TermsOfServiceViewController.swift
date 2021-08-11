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
    
    @IBOutlet weak var fullNameImage: UIImageView!
    @IBOutlet weak var passwordImage: UIImageView!
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var firstNameErrorLbl: UILabel!
    @IBOutlet weak var EmailLine: UIView!
    @IBOutlet weak var passwordLine: UIView!
    @IBOutlet weak var emailErrorLbl: UILabel!
    @IBOutlet weak var firstNameLine: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordErrorLbl: UILabel!
    @IBOutlet weak var fullnameErrorImage: UIImageView!
    @IBOutlet weak var emailErrorImage: UIImageView!
    @IBOutlet weak var passwordErrorImage: UIImageView!
    @IBOutlet weak var SignUp: UIButton!
    
    var viewModel = SignupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameErrorLbl.isHidden = true
        fullNameImage.isHidden = true
        fullnameErrorImage.isHidden = true
        emailImage.isHidden  = true
        emailErrorImage.isHidden  = true
        emailErrorLbl.isHidden  = true
        firstName.delegate = self
        email.delegate = self
        passwordErrorLbl.isHidden = true
        passwordImage.isHidden = true
        passwordErrorImage.isHidden = true
        SignUp.isHidden = true
        password.delegate = self
        
        
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
extension TermsOfServiceViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            if textField.text == "" {
                
                DispatchQueue.main.async {
                    self.firstNameErrorLbl.isHidden = false
                    self.fullNameImage.isHidden = false
                    self.fullnameErrorImage.isHidden = false
                    self.firstNameErrorLbl.text = "Please type in your first name"
                    self.firstNameErrorLbl.textColor = .red
                    self.fullnameErrorImage.image = UIImage(systemName: "xmark.square.fill")
                    self.firstNameLine.backgroundColor = .red
                    self.fullNameImage.image = UIImage(systemName: "xmark.square.fill")
                    self.fullNameImage.tintColor = .red
                }
            }
            else if  textField.text?.hasWhiteSpace == false { 
                DispatchQueue.main.async {
                    
                    self.firstNameErrorLbl.isHidden = false
                    self.fullNameImage.isHidden = false
                    self.fullnameErrorImage.isHidden = false
                    self.firstNameErrorLbl.text = "Please you need to provide both first and last name"
                    self.firstNameErrorLbl.textColor = .red
                    self.fullnameErrorImage.image = UIImage(systemName: "xmark.square.fill")
                    self.fullnameErrorImage.tintColor = .red
                    self.firstNameLine.backgroundColor = .red
                    self.fullNameImage.image = UIImage(systemName: "xmark.square.fill")
                    self.fullNameImage.tintColor = .red
                }
            }
            else if textField.text?.hasWhiteSpace == true && textField.text?.isEmpty == false {
                DispatchQueue.main.async {
                    
                    self.firstNameErrorLbl.isHidden = false
                    self.fullNameImage.isHidden = false
                    self.fullnameErrorImage.isHidden = false
                    self.firstNameErrorLbl.text = "Correct"
                    self.firstNameErrorLbl.textColor = .green
                    self.fullnameErrorImage.image = UIImage(systemName: "checkmark.square.fill")
                    self.fullnameErrorImage.tintColor = .green
                    self.firstNameLine.backgroundColor = .green
                    self.fullNameImage.image = UIImage(systemName: "checkmark.square.fill")
                    self.fullNameImage.tintColor = .green
                }
                
            }
            
            
            
            
        }
        if textField.tag == 2 {
            if email.text?.isEmpty == true {
                DispatchQueue.main.async {
                    
                    self.emailImage.isHidden = false
                    self.emailErrorLbl.isHidden = false
                    self.emailErrorImage.isHidden = false
                    self.emailErrorLbl.text = "Please type in your email"
                    self.emailErrorLbl.textColor = .red
                    self.emailErrorImage.image = UIImage(systemName: "xmark.square.fill")
                    self.emailErrorImage.tintColor = .red
                    self.EmailLine.backgroundColor = .red
                    self.emailImage.image = UIImage(systemName: "xmark.square.fill")
                    self.emailImage.tintColor = .red
                }
            }
            else if  textField.text?.isValidEmail == false {
                DispatchQueue.main.async {
                    
                    self.emailImage.isHidden = false
                    self.emailErrorLbl.isHidden = false
                    self.emailErrorImage.isHidden = false
                    self.emailErrorLbl.text = "Please type in your email"
                    self.emailErrorLbl.textColor = .red
                    self.emailErrorImage.image = UIImage(systemName: "xmark.square.fill")
                    self.emailErrorImage.tintColor = .red
                    self.EmailLine.backgroundColor = .red
                    self.emailImage.image = UIImage(systemName: "xmark.square.fill")
                    self.emailImage.tintColor = .red
                }
            }
            else if textField.text?.isValidEmail == true && textField.text?.isEmpty == false {
                DispatchQueue.main.async {
                    self.emailImage.isHidden = false
                    self.emailErrorLbl.isHidden = false
                    self.emailErrorImage.isHidden = false
                    self.emailErrorLbl.text = "Correct"
                    self.emailErrorLbl.textColor = .green
                    self.emailErrorImage.image = UIImage(systemName: "checkmark.square.fill")
                    self.emailErrorImage.tintColor = .green
                    self.EmailLine.backgroundColor = .green
                    self.emailImage.image = UIImage(systemName: "checkmark.square.fill")
                    self.emailImage.tintColor = .green
                }
            }
        }
        if textField.tag == 3 {
            if password.text?.isEmpty == true {
                DispatchQueue.main.async {
                    self.passwordImage.isHidden = false
                    self.passwordErrorImage.isHidden = false
                    self.passwordErrorLbl.isHidden = false
                    self.passwordErrorLbl.text = "Please type in your password"
                    self.passwordErrorLbl.textColor = .red
                    self.passwordErrorImage.image = UIImage(systemName: "xmark.square.fill")
                    self.passwordErrorImage.tintColor = .red
                    self.passwordLine.backgroundColor = .red
                    self.passwordImage.image = UIImage(systemName: "xmark.square.fill")
                    self.passwordImage.tintColor = .red
                }
            }
            else if  textField.text?.isValidPassword == false {
                DispatchQueue.main.async {
                    
                    self.passwordImage.isHidden = false
                    self.passwordErrorImage.isHidden = false
                    self.passwordErrorLbl.isHidden = false
                    self.passwordErrorLbl.text = "Please type in a valid password"
                    self.passwordErrorLbl.textColor = .red
                    self.passwordErrorImage.image = UIImage(systemName: "xmark.square.fill")
                    self.passwordErrorImage.tintColor = .red
                    self.passwordLine.backgroundColor = .red
                    self.passwordImage.image = UIImage(systemName: "xmark.square.fill")
                    self.passwordImage.tintColor = .red
                }
            }
            else if textField.text?.isValidPassword == true && textField.text?.isEmpty == false {
                DispatchQueue.main.async {
                    self.passwordImage.isHidden = false
                    self.passwordLine.backgroundColor = .green
                    self.passwordImage.image = UIImage(systemName: "checkmark.square.fill")
                    self.passwordImage.tintColor = .green
                    self.SignUp.isHidden = false
                    self.fullnameErrorImage.isHidden = true
                    self.firstNameErrorLbl.isHidden = true
                    self.emailErrorLbl.isHidden = true
                    self.emailErrorImage.isHidden = true
                    self.passwordErrorLbl.isHidden = true
                    self.passwordErrorImage.isHidden = true
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}

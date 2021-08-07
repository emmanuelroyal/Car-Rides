//
//  TermsOfServiceViewModel.swift
//  Car-Rides
//
//  Created by Decagon on 7/29/21.
//

import UIKit
import FirebaseAuth

class SignupViewModel {
    
    func signupUser(with email: String, password: String, completion: @escaping ((Bool) -> Void)) {
        
    }
    
    func validateTextField(inView: UIViewController, fullName: String, email: String, password: String) -> Bool {
        if !fullName.hasWhiteSpace {
            inView.showAlert(alertText: "Oops", alertMessage: "Please, enter your firstname and lastname")
            return false
        }
        
        if fullName == "" {
            inView.showAlert(alertText: "Oops", alertMessage: "Please, enter your full name")
            return false
        }
        
        if email == "" {
            inView.showAlert(alertText: "Oops", alertMessage: "Please, enter your email")
            return false
        }
        
        if email  == "" && email.isValidEmail == false {
            inView.showAlert(alertText: "Invalid Email", alertMessage: "Please, enter a valid email")
            return false
        }
        
        if password == "" {
            inView.showAlert(alertText: "Oops", alertMessage: "Please enter your password")
            return false
        }
        
        if password != "" && password.isValidPassword == false {
            inView.showAlert(alertText: "Oops",
                             alertMessage: "Password must be alphanumeric and must be greater than 8 characters")
        }
        return true
    }
    
    func toggle(passField: UITextField, secureButton: UIButton){
        passField.isSecureTextEntry.toggle()
        let imageName = passField.isSecureTextEntry ? "eye" : "eye.slash"
        secureButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    func loginUser(with email: String, password: String, completion: @escaping ((Bool) -> Void)) {
        let manager = AuthManager()
        manager.validateLogin(with: email, password: password) { success in
            completion(success)
        }
    }
    

}

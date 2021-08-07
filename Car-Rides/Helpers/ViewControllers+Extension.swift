//
//  ViewControllers+Extension.swift
//  Car-Rides
//
//  Created by Decagon on 8/6/21.
//
import UIKit
extension UIViewController {
    
    func showAlert (alertText: String, alertMessage: String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationItem.backButtonTitle = " "
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = .systemBlue
        self.navigationItem.hidesBackButton = true
    }
    
     func navigateToLoginPage() {
        let newStoryboard = UIStoryboard(name: "ProfileRegistration", bundle: nil)
        let newController = newStoryboard
            .instantiateViewController(identifier: "Storyboard2") as ProfileRegistrationViewController
        newController.modalTransitionStyle = .crossDissolve
        newController.modalPresentationStyle = .fullScreen
        present(newController, animated: true, completion: nil)
    }
    
    func navigateToWelcome() {
        let newStoryboard = UIStoryboard(name: "NotificationAlert", bundle: nil)
        let newController = newStoryboard
            .instantiateViewController(identifier: "StoryBoard4") as NotificationAlertViewController
        newController.modalTransitionStyle = .crossDissolve
        newController.modalPresentationStyle = .fullScreen
        present(newController, animated: true, completion: nil)
}
    
    func navigateToSearch() {
        let newStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let newController = newStoryboard
            .instantiateViewController(identifier: "search") as SearchMapViewController
        newController.modalTransitionStyle = .crossDissolve
        newController.modalPresentationStyle = .fullScreen
        present(newController, animated: true, completion: nil)
}
    
    func navigateToMpage() {
        let newStoryboard = UIStoryboard(name: "Messsages", bundle: nil)
        let newController = newStoryboard
            .instantiateViewController(identifier: "StoryBoard9") as MesssagesViewController
        newController.modalTransitionStyle = .crossDissolve
        newController.modalPresentationStyle = .fullScreen
        present(newController, animated: true, completion: nil)
}
    func navigateToYpage() {
        let newStoryboard = UIStoryboard(name: "YourTrips", bundle: nil)
        let newController = newStoryboard
            .instantiateViewController(identifier: "StoryBoard10") as YourTripsViewController
        newController.modalTransitionStyle = .crossDissolve
        newController.modalPresentationStyle = .fullScreen
        present(newController, animated: true, completion: nil)
}
    
    
    
    
    func navigateToSignUp() {
        let newStoryboard = UIStoryboard(name: "TermsOfService", bundle: nil)
        let newController = newStoryboard
            .instantiateViewController(identifier: "StoryBoard3") as TermsOfServiceViewController
        newController.modalTransitionStyle = .crossDissolve
        newController.modalPresentationStyle = .fullScreen
        present(newController, animated: true, completion: nil)
}
    func navigateToHome() {
        let newStoryboard = UIStoryboard(name: "HomePage", bundle: nil)
        let newController = newStoryboard
            .instantiateViewController(identifier: "StoryBoard7") as HomePageViewController
        newController.modalTransitionStyle = .crossDissolve
        newController.modalPresentationStyle = .fullScreen
        present(newController, animated: true, completion: nil)
}

class AlertController {
    static func showAlert(_ inViewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        inViewController.present(alert, animated: true, completion: nil)
    }
}
class AlertService {
    static func showAlert(_ inViewController: UIViewController, style: UIAlertController.Style, title: String?, message: String?, actions: [UIAlertAction] = [UIAlertAction(title: "Ok", style: .cancel, handler: nil)], completion: (() -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            alert.addAction(action)
        }
        inViewController.present(alert, animated: true, completion: nil)
    }
    
}
}

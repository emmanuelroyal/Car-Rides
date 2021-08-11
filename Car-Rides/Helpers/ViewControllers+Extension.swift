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
    func  getCurrentTime() -> String {

        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        var month = "\(calendar.component(.month, from: date))"
        let day = calendar.component(.day, from: date)
        switch month {
        case "1" :
         month =  "JAN"
        case "2" :
            month = "FEB"
        case "3" :
            month = "MAR"
        case "4" :
            month = "APR"
        case "5" :
            month = "MAY"
        case "6" :
            month = "JUN"
        case "7" :
            month = "JUL"
        case "8" :
            month = "AUG"
        case "9" :
            month = "SEPT"
        case "10" :
            month = "OCT"
        case "11" :
            month = "NOV"
        default:
            month = "DEC"
        }
        let realTime = "\(year)-\(month)-\(day)"
        return realTime
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


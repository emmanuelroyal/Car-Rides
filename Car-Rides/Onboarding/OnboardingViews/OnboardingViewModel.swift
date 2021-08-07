//
//  OnboardingViewModel.swift
//  Car-Rides
//
//  Created by Decagon on 7/29/21.
//

import UIKit

class OnboardingViewModel {
    var slides: [OnboardingSlide] = []
    var updateButton: ((String, Int) -> Void)?
    var currentPage = 0 {
        didSet {
            if currentPage == slides.count - 1 {
                updateButton?("Get Started ", currentPage)
            } else {
                updateButton?(" Next ", currentPage)
            }
        }
    }
    
    init() {
        slides = [
            OnboardingSlide(title: "Commute in great comfort", image: UIImage(named: "adam-stefanca-hdMSxGizchk-unsplash")!), OnboardingSlide(title: "Enjoy easy on the pocket rides", image: UIImage(named: "thibault-penin-a8r2KKLSntA-unsplash")!)
        ]
    }

}

//
//  OnBoardingCollectionViewCell.swift
//  Car-Rides
//
//  Created by Decagon on 7/31/21.
//

import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "OnboardingCollectionViewCell"
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var Label: UILabel!
    
    func setUp(_ slide: OnboardingSlide){
        image.image = slide.image
        Label.text = slide.title
    }
}

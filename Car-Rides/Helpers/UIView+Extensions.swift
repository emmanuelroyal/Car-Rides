//
//  UIView+Extensions.swift
//  Car-Rides
//
//  Created by Decagon on 7/30/21.
//

import UIKit
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.cornerRadius
        } set {
            self.layer.cornerRadius = newValue
        }
    }
    
    private var identifier: String {
        return String(describing: self)
    }
}

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}


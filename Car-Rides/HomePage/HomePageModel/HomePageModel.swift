//
//  HomePageModel.swift
//  Car-Rides
//
//  Created by Decagon on 7/29/21.
//

import UIKit

struct HomeTable {
    let name: String
    let storyboardName: String
    let storyBoard: String
    let viewController: UIViewController
}

struct Request: Codable {
    let status: String
    let routes: [Route]
}

struct Route : Codable  {
    let legs: [Leg]
}

struct Leg : Codable {
    let duration: Distance
    let distance: Distance
}

struct Distance : Codable {
    let text: String
    let value: Int
}

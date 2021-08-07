//
//  HomePageViewModel.swift
//  Car-Rides
//
//  Created by Decagon on 7/29/21.
//

import UIKit
class HomeViewModel {
    
    var items: [HomeTable] = []
    
    init() {
        items = [
            HomeTable(name: "Messsages", storyboardName: "Messsages", storyBoard: "StoryBoard9", viewController: MesssagesViewController()), HomeTable(name: " Do more with your accout", storyboardName: "Messages", storyBoard: "StoryBoard9", viewController: MesssagesViewController()), HomeTable(name: "Make money driving", storyboardName: "Messages", storyBoard: "StoryBoard9", viewController: MesssagesViewController()), HomeTable(name: "Your Trips", storyboardName: "YourTrips", storyBoard: "StoryBoard10", viewController: YourTripsViewController()),
            HomeTable(name: "Wallet", storyboardName: "Wallet", storyBoard: "StoryBoard11", viewController: WalletViewController()), HomeTable(name: "Help", storyboardName: "Help", storyBoard: "StoryBoard23", viewController: HelpViewController()), HomeTable(name: "Settings", storyboardName: "Settings", storyBoard: "StoryBoard24", viewController: SettingsViewController())
        ]
    }

}

//
//  TableViewCell.swift
//  Car-Rides
//
//  Created by Decagon on 8/15/21.
//

import UIKit

class TripsTableViewCell: UITableViewCell {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionlbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(with trip: TripsModel){
        self.price.text = trip.price
        self.title.text = trip.title
        self.descriptionlbl.text = trip.descriptionTag
        
    }
    

}

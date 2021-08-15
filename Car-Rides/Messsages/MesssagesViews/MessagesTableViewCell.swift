//
//  MessagesTableViewCell.swift
//  Car-Rides
//
//  Created by Decagon on 8/12/21.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {
    static let identifier = "MessagesTableViewCell"
    @IBOutlet weak var readIcon: UIView!
    @IBOutlet weak var messageTitle: UILabel!
    @IBOutlet weak var messageBody: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with model: MessageTable) {
        self.readIcon.backgroundColor = model.opened == "true"  ? .gray : .blue
        self.messageTitle.text = model.title
        self.messageBody.text = model.body
        self.timeLbl.text = model.time
    }
    
    
}

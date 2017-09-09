//
//  TableViewCell.swift
//  HACodingChallenge
//
//  Created by Chris Conner on 9/6/17.
//  Copyright © 2017 Chris Conner. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    func setEvent(event: Event) {
        
        titleLabel.text = event.title
        locationLabel.text = event.location
        dateTimeLabel.text = event.dateTime
        
        // Still need to download and set image
        
        
        
    }
    
}

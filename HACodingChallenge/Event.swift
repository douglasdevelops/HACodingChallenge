//
//  Event.swift
//  HACodingChallenge
//
//  Created by Chris Conner on 9/8/17.
//  Copyright © 2017 Chris Conner. All rights reserved.
//

import Foundation

class Event {
    
    private let kId             = "id"
    private let kTitle          = "title"
    private let kLocation       = "display_location"
    private let kDateTime       = "datetime_utc"
    private let kLocationImage  = "image"
    
    var id: Int?
    var title: String?
    var location: String?
    var dateTime: String?
    var locationImage: String?
    
    
    init(data: [String : Any]) {
        id              = data[kId] as? Int
        title           = data[kTitle] as? String
        location        = data[kLocation] as? String
        dateTime        = data[kDateTime] as? String
        locationImage   = data[kLocationImage] as? String
    }
}

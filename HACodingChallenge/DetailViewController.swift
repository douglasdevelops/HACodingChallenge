//
//  DetailViewController.swift
//  HACodingChallenge
//
//  Created by Chris Conner on 9/6/17.
//  Copyright © 2017 Chris Conner. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //image and labels
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    var titleString:String!
    var dateAndTimeString:String!
    var cityString:String!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI() {
        self.dateTimeLabel.text = titleString
        self.locationLabel.text = cityString
        
    }

}

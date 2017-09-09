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
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var titleString:String!
    var dateAndTimeString:String!
    var cityString:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        title = titleString
        
        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: "BackButton.png"), for: .normal)
        backbutton.setTitle("Back", for: .normal)
        backbutton.setTitleColor(backbutton.tintColor, for: .normal)
        backbutton.addTarget(self, action: Selector(("backAction")), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
    }
    

    @IBAction func backAction(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func updateUI() {
        dateTimeLabel.text = dateAndTimeString
        locationLabel.text = cityString
        titleLabel.text = titleString
        
        
    }
    
}

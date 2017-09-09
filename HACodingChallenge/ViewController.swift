//
//  ViewController.swift
//  HACodingChallenge
//
//  Created by Chris Conner on 9/6/17.
//  Copyright © 2017 Chris Conner. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    let baseURL = "https://api.seatgeek.com/2/"
    var newSearchText = "nothing"
    var myEvents: [Event] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //This is for our UISearchController
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        tableView.delegate = self
        tableView.dataSource = self 
    }
    
    //Any time a user types a character into the search field we will call the JSON handler and pass the new value
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
        //    let newSearchText = searchText.replacingOccurrences(of: " ", with: "+") as String
            downloadJsonWithURL()
        } else {
            print("No updates yet")
        }
        self.tableView.reloadData()
}
    
    func downloadJsonWithURL() {
        
        // Building the URL
        let seatGeekClientID = "ODgwMzA0OHwxNTA0NzM4MTE2LjI1"
        let searchQuery = searchController.searchBar.text
        let eventURL = baseURL + "events?client_id=\(seatGeekClientID)&q=\(searchQuery!)"
        
        
        let url = URL(string: eventURL)
        
        var request = URLRequest(url: url as! URL)
        
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                print(jsonObj!.value(forKey: "events"))
                
                // Pull out items we need
                // Create temp dictionary
                // Input into dictionary
                // Create event with dictionary
                
                if let eventsArray = jsonObj!.value(forKey: "events") as? [[String:Any]] {
                    
                    for event in eventsArray {
                        
                        // Grabbing all the information I need. Digging through JSON
                        
                        //Top Level
                        let title    = event["title"] as! String
                        let dateTime = event["datetime_utc"] as! String
                        let id       = event["id"] as! Int
                        
                        
                        // We had to dig to some sub-nodes
                        let venueDict = event["venue"] as! [String:Any]
                        let location = venueDict["display_location"] as! String
                        
                        let performersArray = event["performers"] as! [[String:Any]]
                        let searchedItemDict = performersArray.first as! [String:Any]
                        
                        let locationImage = searchedItemDict["image"] as? String
                        
                        
                        // Throw these items into my dictionary
                        
                        var tempDict: [String:Any?] = [
                            "id": id,
                            "title": title,
                            "datetime_utc": dateTime,
                            "display_location": location,
                            "image": locationImage
                        ]
                        
                        let newEvent = Event(data: tempDict)
                        
                        self.myEvents.append(newEvent)
                    }
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }).resume()
    }

   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        let event = myEvents[indexPath.row]
        cell.setEvent(event: event)
        return cell
    }
    
    //To send users from the TableView to the Detail View with the necessary info
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let event = myEvents[indexPath.row]
        
        vc.titleString = event.title
        vc.dateAndTimeString = event.dateTime
        vc.cityString = event.location
        
        navigationController?.pushViewController(vc, animated: true)
        
        searchController.dismiss(animated: false, completion: nil)
    }
}











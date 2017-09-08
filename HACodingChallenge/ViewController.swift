//
//  ViewController.swift
//  HACodingChallenge
//
//  Created by Chris Conner on 9/6/17.
//  Copyright © 2017 Chris Conner. All rights reserved.
//

import UIKit

    class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
        
        let urlString = "https://api.seatgeek.com/2"
    
        

        
        var titleArray = [String]()
        var cityArray = [String]()
        var dateAndTimeArray = [String]()
        var imageSmallArray = [String]()
        var imageMediumArray = [String]()
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.downloadJsonWithURL()
            
            // Do any additional setup after loading the view, typically from a nib.
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        func downloadJsonWithURL() {
            let url = NSURL(string: urlString)
            
            var request = URLRequest(url: url as! URL)
            request.setValue("ODgwMzA0OHwxNTA0NzM4MTE2LjI1", forHTTPHeaderField: "d7a462407261e9c7dc6433aefccb69402368a1b27743d996a7d936df3b7affce")
            
            URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
                
                if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                    print(jsonObj!.value(forKey: "events"))
                    
                    if let eventsArray = jsonObj!.value(forKey: "events") as? NSArray {
                        for event in eventsArray{
                            if let eventDict = event as? NSDictionary {
                                if let title = eventDict.value(forKey: "title") {
                                    self.titleArray.append(title as! String)
                                }
                                if let city = eventDict.value(forKey: "city") {
                                    self.cityArray.append(city as! String)
                                }
                                if let dateAndtime = eventDict.value(forKey: "datetime_local") {
                                    self.dateAndTimeArray.append(dateAndtime as! String)
                                }
                                if let imageSmall = eventDict.value(forKey: "small") {
                                    self.imageSmallArray.append(imageSmall as! String)
                                }
                                if let imageMedium = eventDict.value(forKey: "medium") {
                                    self.imageMediumArray.append(imageMedium as! String)
                                }
                                
                            }
                        }
                    }
                    
                    OperationQueue.main.addOperation({
                        self.tableView.reloadData()
                    })
                }
            }).resume()
        }
        
        
        func downloadJsonWithTask() {
            
            let url = NSURL(string: urlString)
            
            var downloadTask = URLRequest(url: (url as? URL)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 20)
            
            downloadTask.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: downloadTask, completionHandler: {(data, response, error) -> Void in
                
                let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                
                print(jsonData)
                
            }).resume()
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return titleArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
            cell.titleLabel.text = titleArray[indexPath.row]
            cell.locationLabel.text = cityArray[indexPath.row]
            cell.dateTimeLabel.text = dateAndTimeArray[indexPath.row]
            
           
            return cell
        }
        
        //To send users from the TableView to the Detail View with the necessary info
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController

            vc.titleString = titleArray[indexPath.row]
            vc.dateAndTimebString = dateAndTimeArray[indexPath.row]
            vc.cityString = cityArray[indexPath.row]
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    






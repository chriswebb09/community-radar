//
//  InitialViewController.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/10/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//
import UIKit
import MapKit
import SwiftSpinner


class InitialViewController: UIViewController {
    var detailsArray = ["Finance","Education","Transportation", "Demographics"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        navBar()
        statsTableView()
        ratingTextView()
    }
    
    func ratingTextView() {
        
        let text1 = "9.5"
        
        let label = UILabel(frame : CGRect(x:60, y:90, width:90, height:100))
        view.addSubview(label)
        
        label.backgroundColor = UIColor.blueColor()
        label.text = text1
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name:"AppleSDGothicNeo-Light", size:66)
        label.sendSubviewToBack(label)
    }
    
    func statsTableView() {
        let tableView = UITableView(frame: view.bounds, style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        view.sendSubviewToBack(tableView)
        tableView.frame.origin.y += 366
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //        if indexPath.section == 0 && indexPath.row == 0 {
        //
        //            return 333
        //        }
        return 66
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //return 2
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if section == 0 {
        //            return 1
        //        }
        
        return detailsArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = TableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier",locationName: "New York City", description:"Description", score:"90")
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print(detailsArray[indexPath.row])
        
    }
    
    func navBar() {
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 50))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Statistics")
        let homeItem = UIBarButtonItem.init(title: "Home", style: .Done, target: nil, action: #selector(dismissView))
        
        navItem.leftBarButtonItem = homeItem
        
        navBar.setItems([navItem], animated: false)
        navBar.alpha = 1.0
        navBar.layer.zPosition = 3
        
        let button: UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: "settings-4.png"), forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(settingButtonPushed), forControlEvents: UIControlEvents.TouchUpInside)
        button.frame = CGRectMake(3, 3, 33, 33)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        navItem.rightBarButtonItem = barButton
        navBar.barTintColor = UIColor.whiteColor()
        navBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name:"AppleSDGothicNeo-Regular", size: 34)!,  NSForegroundColorAttributeName: UIColor.blackColor()]
    }
    
    func dismissView() {
        SwiftSpinner.showWithDuration(99.0, title: "TEAM DRAGON")
        SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 33.0))
        dismissViewControllerAnimated(true, completion: nil)
        SwiftSpinner.hide()
    }
    
    func settingButtonPushed() {
        print("Settings Pushed")
    }
}
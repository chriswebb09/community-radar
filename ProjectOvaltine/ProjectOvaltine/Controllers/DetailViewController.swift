//
//  DetailViewController.swift
//  ProgrammaticTabBar
//
//  Created by John Hussain on 8/8/16.
//  Copyright © 2016 John Hussain. All rights reserved.
//

import UIKit

class DetailViewController: UITabBarController, UITabBarControllerDelegate, Tabable, Navigable {
    let resultView = ResultView()
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        self.setupTabBar()
        self.setupNavBar()
        self.tabBar.tintColor = UIColor.blueColor()
    }
}























//    func initTabBarController() {
//        let tabViewController1 = TabViewController1()
//        let tabViewController2 = TabViewController2()
//        let tabViewController3 = TabViewController3()
//        let tabViewController4 = TabViewController4()
//        let tabViewController5 = TabViewController5()
//
//        let item1 = tabViewController1
//        let item2 = tabViewController2
//        let item3 = tabViewController3
//        let item4 = tabViewController4
//        let item5 = tabViewController5
//
//        let icon1 = UITabBarItem(title: "Statistics", image: UIImage(named: "rating.png"), tag: 0)
//        let icon2 = UITabBarItem(title: "Finance", image: UIImage(named: "emp.png"), tag: 1)
//        let icon3 = UITabBarItem(title: "Education", image: UIImage(named: "edu.png"), tag: 2)
//        let icon4 = UITabBarItem(title: "Transportation", image: UIImage(named: "trans.png"), tag: 3)
//        let icon5 = UITabBarItem(title: "Demographics", image: UIImage(named: "resource.png"), tag: 4)
//
//        item1.tabBarItem = icon1
//        item2.tabBarItem = icon2
//        item3.tabBarItem = icon3
//        item4.tabBarItem = icon4
//        item5.tabBarItem = icon5
//
//        let controllers = [item1, item2, item3, item4, item5]
//        self.viewControllers = controllers
//
//    }
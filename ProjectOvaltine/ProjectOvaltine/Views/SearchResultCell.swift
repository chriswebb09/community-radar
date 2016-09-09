//
//  SearchResultCell.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/12/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import SnapKit

class SearchResultCell: UITableViewCell {
    
    var comparisonScoreLabel = UILabel()
    var scoreLabel:UILabel! = UILabel()
    var resultLocationNameLabel:UILabel! = UILabel()
    var resultDescription: UITextView! = UITextView()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.createGraph()
        self.createLabels()
        
        self.contentView.addSubview(self.scoreLabel)
        self.contentView.addSubview(self.resultLocationNameLabel)
        self.contentView.addSubview(self.comparisonScoreLabel)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.createGraph()
        self.createLabels()
        
        self.contentView.addSubview(self.scoreLabel)
        self.contentView.addSubview(self.resultLocationNameLabel)
        self.contentView.addSubview(self.comparisonScoreLabel)
        
        self.setupView()
    }
    
    convenience init(style: UITableViewCellStyle, reuseIdentifier: String?, parameterDescription: String, description:String, score:String) {
        
        self.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.scoreLabel.text = score
        self.comparisonScoreLabel.text = description
        self.resultLocationNameLabel.text = parameterDescription
        self.createGraph()
        self.createLabels()
        
        self.contentView.clipsToBounds = true
        self.contentView.addSubview(self.scoreLabel)
        self.contentView.addSubview(self.resultLocationNameLabel)
        self.contentView.addSubview(self.comparisonScoreLabel)
        
        self.setupView()
    }
    
    func createGraph() {
        
        // MARK: - GREY LABEL RIGHT
        
        self.comparisonScoreLabel.textColor = UIColor.blackColor()
        self.comparisonScoreLabel.font = UIFont(name:"Helvetica-Light", size:14)
        self.comparisonScoreLabel.textAlignment = NSTextAlignment.Center
        self.comparisonScoreLabel.layer.backgroundColor = UIColor.clearColor().CGColor
        self.comparisonScoreLabel.layer.borderWidth = 1.0
    }
    
    
    func createLabels() {
        
        self.resultLocationNameLabel.font = UIFont(name:"Helvetica-Light", size:15)
        self.resultLocationNameLabel.textAlignment = NSTextAlignment.Left
        self.resultLocationNameLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: - GRAY LABEL LEFT
        
        self.scoreLabel.textColor = UIColor.blackColor()
        self.scoreLabel.font = UIFont(name:"Helvetica-Light", size:14)
        self.scoreLabel.textAlignment = NSTextAlignment.Center
        self.scoreLabel.layer.backgroundColor = UIColor.clearColor().CGColor
        self.scoreLabel.layer.borderWidth = 1.0
    }
    
    func setupView() {
        
        self.scoreLabel.snp_makeConstraints { (make) -> Void in
            
            make.height.equalTo(45)
            make.width.equalTo(99)
            make.left.equalTo(self.contentView).offset(20)
            make.top.equalTo(self.contentView).offset(50)
        }
        
        self.resultLocationNameLabel.snp_makeConstraints { (make) -> Void in
            
            make.height.equalTo(60)
            make.width.equalTo(300)
            make.center.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).offset(-60)
        }
        
        self.resultDescription.snp_makeConstraints { (make) -> Void in
            
            make.size.equalTo(100)
        }
        
        self.comparisonScoreLabel.snp_makeConstraints { (make) -> Void in
            
            make.height.equalTo(45)
            make.width.equalTo(99)
            make.right.equalTo(self.contentView).inset(20)
            make.top.equalTo(self.contentView).inset(50)
        }
    }
    
}
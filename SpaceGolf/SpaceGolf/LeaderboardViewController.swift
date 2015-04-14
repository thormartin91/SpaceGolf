//
//  LeaderboardViewController.swift
//  SpaceGolf
//
//  Created by Jonas André Dalseth on 16.03.15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import Foundation
import UIKit

class LeaderboardViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    //Overskriften
    @IBOutlet weak var headerLabel: UILabel!
    
    
    let leaderboard: LeaderboardModel! = LeaderboardModel()

    var highScores: [String: Int]?
    var standings : [String] {
        return sorted(self.highScores!.keys.array as [String]) {self.highScores![$0]! < self.highScores![$1]!}
    }
    
    override func viewDidLoad() {
        self.highScores = LocalDataHandler.getObjectFromFile(LocalDataFile.PlayerData, key: LocalDataKey.HighScore) as? [String: Int]
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bgnd")!)
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell
        
        let name = self.standings[indexPath.row] as String
        cell!.textLabel?.text = name
        cell!.detailTextLabel?.text = "\(self.highScores![name]!)"
        
        return cell!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.highScores != nil {
            return self.highScores!.count
        }
        
        return 0
    }
    
    @IBAction func back(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
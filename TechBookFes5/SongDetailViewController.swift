//
//  SongDetailViewController.swift
//  TechBookFes5
//
//  Created by crea on 2018/10/07.
//  Copyright © 2018 crea. All rights reserved.
//

import UIKit

class SongDetailViewController: UIViewController {

    var song: Song!
    
    @IBOutlet weak var durationLabel:       UILabel!
    @IBOutlet weak var timesLabel:          UILabel!
    @IBOutlet weak var premiereDateLabel:   UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title   = song.name
        self.durationLabel.text     = (song.duration?.secondify()) ?? "No data"
        self.timesLabel.text        = (song.times?.description)    ?? "No data"
        self.premiereDateLabel.text = song.premiereDate
        
        let childController = self.children[0] as! PerformedAtSongTableViewController
        
        childController.performedAt = self.song.performedAt
    }
    
}

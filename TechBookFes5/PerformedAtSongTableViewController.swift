//
//  PerformedAtSongTableViewController.swift
//  TechBookFes5
//
//  Created by crea on 2018/10/07.
//  Copyright © 2018 crea. All rights reserved.
//

import UIKit

class PerformedAtSongTableViewController: UITableViewController {

    var performedAt: [Live] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.performedAt.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text       = self.performedAt[indexPath.row].name
        cell.detailTextLabel?.text = self.performedAt[indexPath.row].date
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Performed at"
    }

}

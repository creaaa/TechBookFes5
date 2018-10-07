
//
//  SongListViewController.swift
//  TechBookFes5
//
//  Created by crea on 2018/10/07.
//  Copyright © 2018 crea. All rights reserved.
//

import UIKit

class SongListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var songs: [Song]         = []
    var filteredSongs: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupSearchController()
        request()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private func setup() {
        self.tableView.delegate   = self
        self.tableView.dataSource = self
    }
    
    private func setupSearchController() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater                     = self
        search.dimsBackgroundDuringPresentation         = false
        self.navigationItem.searchController            = search
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.definesPresentationContext = true
    }
}

extension SongListViewController {
    func request() {
        let url = URL(string: "http://localhost:7474/graphql/")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let token = "YOUR_TOKEN"
        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let query = """
            query {
                songs: Song {
                    name
                    duration
                    times
                    premiereDate
                    performedAt(first: 10) {
                        name
                        date
                    }
                }
            }
        """
        let body = ["query": query]
        request.httpBody = try! JSONSerialization.data(withJSONObject: body, options: [])
        request.cachePolicy = .reloadIgnoringLocalCacheData // Avoid 412
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if error == nil,
                let data = data,
                let _ = response as? HTTPURLResponse {
                
                let decoder = JSONDecoder()
                let data = try! decoder.decode(Data.self, from: data)
                let songs = data.data.songs
                
                self.songs         = songs
                self.filteredSongs = songs
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }.resume()
    }
}

extension SongListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToNextViewController(indexPath: indexPath)
    }
    private func goToNextViewController(indexPath: IndexPath) {
        let sb  = UIStoryboard(name: "Main", bundle: nil)
        let vc  = sb.instantiateViewController(withIdentifier: "SongDetail") as! SongDetailViewController
        vc.song = self.songs[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SongListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredSongs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.filteredSongs[indexPath.row].name
        return cell
    }
}

extension SongListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text,
            text.count > 0 {
            filteredSongs = self.songs.filter {
                $0.name.contains(text.lowercased())
            }
        } else {
            filteredSongs = self.songs
        }
        self.tableView.reloadData()
    }
}

//
//  EpisodesController.swift
//  Podcasts
//
//  Created by Dmitrii Timofeev on 24/04/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit
import FeedKit

class EpisodesController : UITableViewController {
    
    //MARK: Properties
    
    var episodes = [Episode]()
    
    var podcast: Podcast? {
        
        didSet{
            navigationItem.title = "\(podcast?.trackName ?? "")"
            fetchEpisodes()
        }
    }
    
    
 //MARK: ---------------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
    }
    
    
    fileprivate func fetchEpisodes() {
        
        print("fetching: \(podcast?.feedUrl ?? "")")
        
        guard let feedUrl = podcast?.feedUrl else { return }
        
        NetworkService.shared.fetchEpisodes(feedUrl: feedUrl) { (episodes) in
            self.episodes = episodes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    

    fileprivate func setupTableView() {
        let nib = UINib(nibName: "EpisodeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EpisodeCell")
    }
    
     //MARK: Table view methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath) as! EpisodeCell
        
        cell.episode = episodes[indexPath.row]
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        134
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let episode = episodes[indexPath.row]
        
        
        let mainTabBarController = UIApplication.mainTabBarController()
        
        mainTabBarController?.maximizePlayerDetails(episode: episode, playlistEpisodes: self.episodes)
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .large
        activityIndicatorView.color = .darkGray
        activityIndicatorView.startAnimating()
        return activityIndicatorView
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return episodes.count == 0 ? 150 : 0
    }
    
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
}

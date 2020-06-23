//
//  MainTabBarController.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 18/05/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit


class MainTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().prefersLargeTitles = true
        
        setupViewControllers()
        setupPlayerDetailsView()
        
    }
    
    // MARK: setup Maib tabBar
    
    private func setupViewControllers() {
        
        viewControllers = [
            generateNavigationController(with: DictController(), title: "Dict", image:  UIImage(systemName: "book")!),
            generateNavigationController(with: PodcastsSearchController(), title: "Media", image: UIImage(systemName: "arrowtriangle.right.square")!),
            generateNavigationController(with: CardsController(), title: "Cards", image:  UIImage(systemName: "app.badge")!),
            generateNavigationController(with: MostUsedWordsController(), title: "Quiz", image:  UIImage(systemName: "text.justifyright")!)
        ]
    }
    
    fileprivate func generateNavigationController(with rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        let navController = CustomNavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        
        return navController
    }
    
    
    
    // MARK: Player properties and methods
    
    let playerDetailsView = PlayerDetailsView.initFromNib()
    
    var maximizedTopAnchorConstraint: NSLayoutConstraint!
    var minimizedTopAnchorConstraint: NSLayoutConstraint!
    var bottomAnchorConstraint: NSLayoutConstraint!
    
    
    private func setupPlayerDetailsView() {
         
         view.insertSubview(playerDetailsView, belowSubview: tabBar)
         playerDetailsView.translatesAutoresizingMaskIntoConstraints = false
         bottomAnchorConstraint =  playerDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  view.frame.height)
         bottomAnchorConstraint.isActive = true
         maximizedTopAnchorConstraint =  playerDetailsView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
         maximizedTopAnchorConstraint.isActive = true
         minimizedTopAnchorConstraint = playerDetailsView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant:  -64)
         
         
         playerDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor ).isActive = true
         playerDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
         
         
     }
    
    func minimizePlayerDetails() {
        
        maximizedTopAnchorConstraint.isActive = false
        bottomAnchorConstraint.constant = view.frame.height
        minimizedTopAnchorConstraint.isActive = true
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            
            self.view.layoutIfNeeded()
            self.tabBar.alpha = 1
            self.playerDetailsView.maximizedStackView.alpha = 0
            self.playerDetailsView.minimizedPlayerView.alpha = 1
            
        }, completion: nil)
        
    }
    
    func maximizePlayerDetails(episode: Episode?, playlistEpisodes: [Episode] = []) {
        minimizedTopAnchorConstraint.isActive = false
        maximizedTopAnchorConstraint.isActive = true
        maximizedTopAnchorConstraint.constant = 0
        bottomAnchorConstraint.constant = 0
        
        if episode != nil {
            playerDetailsView.episode = episode
        }
        playerDetailsView.playListEpisodes = playlistEpisodes
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            
            self.view.layoutIfNeeded()
            self.tabBar.alpha = 0
            self.playerDetailsView.maximizedStackView.alpha = 1
            self.playerDetailsView.minimizedPlayerView.alpha = 0
            
        }, completion: nil)
        
    }
    
}




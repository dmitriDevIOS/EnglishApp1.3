//
//  MostUsedWordsController.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 16/06/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//


import UIKit

class MostUsedWordsController: UITableViewController {
    
    let menuController = MenuViewController()
    
    fileprivate let menuWidth : CGFloat = UIScreen.main.bounds.width * 0.8
    fileprivate let velocityOpenThreshold: CGFloat = 500
    fileprivate var isMenuOpened = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupMenuController()
        navigationController?.navigationBar.prefersLargeTitles = false
        
        tableView.backgroundColor = .red
        setupNavigationItems()
        setupPanGesture()
        
        setupDarkCoverView()
        
      
    }
    
    let darkCoverView = UIView()
    
    
    fileprivate func setupDarkCoverView() {
        darkCoverView.alpha = 0
        darkCoverView.backgroundColor = UIColor(white: 0, alpha: 0.8)
        darkCoverView.isUserInteractionEnabled = false
        navigationController?.view.addSubview(darkCoverView)
        darkCoverView.frame = view.frame
        
        let mainWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        mainWindow?.addSubview(darkCoverView)
        darkCoverView.frame = mainWindow?.frame ?? .zero
        
    }
    
    
    fileprivate func setupPanGesture() {
              let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
              view.addGestureRecognizer(panGesture)
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
       
        let translation = gesture.translation(in: view)
        
        if gesture.state == .changed {
            var x = translation.x
            
            if isMenuOpened {
                x += menuWidth
            }
            
            x = min(menuWidth, x)
            x = max(0, x)
            let transform =  CGAffineTransform(translationX: x , y: 0)
            
            menuController.view.transform = transform
            navigationController?.view.transform = transform
            darkCoverView.transform = transform
            
            let alpha = x / menuWidth

            darkCoverView.alpha  = alpha
            
        } else if gesture.state == .ended {
            
            let velocity = gesture.velocity(in: view)
            
            if isMenuOpened {
                if abs(translation.x) < velocityOpenThreshold {
                    handleHide()
                    return
                }
                
                
                if abs(translation.x) < menuWidth / 2 {
                    handleOpen()
                } else {
                    handleHide()
                }
            } else {
                
                if velocity.x > velocityOpenThreshold {
                    handleOpen()
                    return
                }
                
                if translation.x < menuWidth/2 {
                    handleHide()
                } else {
                    handleOpen()
                }
            }
        }

    }
    
    fileprivate func performAnimations(transform: CGAffineTransform) {
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity:  1, options: .curveEaseOut, animations: {
            self.menuController.view.transform = transform
          // transforms only view without navigationController
          //  self.view.transform = transform
        
             self.darkCoverView.transform = transform
            // transforms view and navigationController
            self.navigationController?.view.transform = transform
               }, completion: nil)
       
        
        if transform == .identity {
            self.darkCoverView.alpha = 0
        } else {
            self.darkCoverView.alpha = 1
        }
        
        
    }
    
    @objc private func handleOpen() {

        isMenuOpened = true
        performAnimations(transform: CGAffineTransform(translationX: self.menuWidth, y: 0))
        
    }
    
    @objc private func handleHide() {
        isMenuOpened = false
        //        menuController.view.removeFromSuperview()
        //        menuController.removeFromParent() // opposite to addChild() method the reason why you should call this method is whenever you add a new view conroller inside another view controller you have to remove it from super view and remove it as a child of that parent
        
        performAnimations(transform: .identity)
        
    }
    
    private func setupNavigationItems() {
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(handleOpen))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(handleHide))
        
    }
    
    fileprivate func setupMenuController() {
        menuController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth , height: view.frame.height + 100)
        let mainWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        mainWindow?.addSubview(menuController.view)
        addChild(menuController)  // whenever you add a second view controller we need to call this method, because the VIEWS in the second view controller won't show up correctly
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        cell.textLabel?.text = "row: \(indexPath.row)"
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .orange
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    

    
    
    
    
    
    
}


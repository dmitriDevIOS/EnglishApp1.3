//
//  MediaController.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 18/05/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit


class CardsController : UIViewController {
    
    let registrationButton : UIButton = {
        
        let button = UIButton(type: .system)
        button.backgroundColor = .lightOrange
        button.setTitle("Registration", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 42)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    
    let showCardsButton : UIButton = {
          
          let button = UIButton(type: .system)
          button.backgroundColor = .lightIndigo
          button.setTitle("Show Cards", for: .normal)
          button.tintColor = .black
          button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 42)
          button.translatesAutoresizingMaskIntoConstraints = false
          button.clipsToBounds = true
          button.layer.cornerRadius = 20
          
          return button
      }()
      
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        registrationButton.addTarget(self, action: #selector(handleRegistrationPressed), for: .touchUpInside)
        showCardsButton.addTarget(self, action: #selector(handleShowCards), for: .touchUpInside)
        
        
    }
    
    
    
    
    
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(registrationButton)
        view.addSubview(showCardsButton)
        
        registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -30).isActive = true
        registrationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -200).isActive  = true
        registrationButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        showCardsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
             showCardsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -30).isActive = true
             showCardsButton.bottomAnchor.constraint(equalTo: registrationButton.topAnchor, constant:  -50).isActive  = true
             showCardsButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
    }
    
    
    @objc fileprivate func handleRegistrationPressed() {
        
        let registrationVC = RegistrationController()
        registrationVC.modalTransitionStyle = .crossDissolve
        registrationVC.modalPresentationStyle = .fullScreen
        present(registrationVC, animated: true)
        
    }
    
    @objc fileprivate func handleShowCards() {
        print("Show cards")
    }
    
    
}

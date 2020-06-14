//
//  MediaController.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 18/05/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit
import CardSlider

struct Item: CardSliderItem {
    
    var image: UIImage
    var rating: Int?
    var title: String
    var subtitle: String?
    var description: String?
    
}


class CardsController : UIViewController, CardSliderDataSource {

    
    var data = [Item]()
    
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
        setupItemCards()
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
       
        let vc = CardSliderViewController.with(dataSource: self)
        vc.title = "Welcome"
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated:  true )
    }
    
    
    //MARK: - Data Source Methods
    func item(for index: Int) -> CardSliderItem {
        return data[index]
    }
    
    func numberOfItems() -> Int {
        return data.count
    }
    
    
    
    
    fileprivate func setupItemCards() {
         
     data.append(Item(image: UIImage(named: "slideCard1")!, rating: nil, title: "Shopping", subtitle: "Describe all shopping thing", description: "It is difficult to imagine our life without shopping. On one hand, it’s one of quite important household tasks. Moreover, shopping is the way to get necessary food and clothes. So, if you don’t do it you can’t have all things which make your life so comfortable. On the other hand, it’s believed that for the vast majority of people going shopping is not just duty or necessity but a real pleasure. As far as I know there is so called shopping therapy that helps people to reduce stress buying different goods or even just going window shopping.It is difficult to imagine our life without shopping. On one hand, it’s one of quite important household tasks. Moreover, shopping is the way to get necessary food and clothes. So, if you don’t do it you can’t have all things which make your life so comfortable. On the other hand, it’s believed that for the vast majority of people going shopping is not just duty or necessity but a real pleasure. As far as I know there is so called shopping therapy that helps people to reduce stress buying different goods or even just going window shopping.It is difficult to imagine our life without shopping. On one hand, it’s one of quite important household tasks. Moreover, shopping is the way to get necessary food and clothes. So, if you don’t do it you can’t have all things which make your life so comfortable. On the other hand, it’s believed that for the vast majority of people going shopping is not just duty or necessity but a real pleasure. As far as I know there is so called shopping therapy that helps people to reduce stress buying different goods or even just going window shopping.It is difficult to imagine our life without shopping. On one hand, it’s one of quite important household tasks. Moreover, shopping is the way to get necessary food and clothes. So, if you don’t do it you can’t have all things which make your life so comfortable. On the other hand, it’s believed that for the vast majority of people going shopping is not just duty or necessity but a real pleasure. As far as I know there is so called shopping therapy that helps people to reduce stress buying different goods or even just going window shopping.It is difficult to imagine our life without shopping. On one hand, it’s one of quite important household tasks. Moreover, shopping is the way to get necessary food and clothes. So, if you don’t do it you can’t have all things which make your life so comfortable. On the other hand, it’s believed that for the vast majority of people going shopping is not just duty or necessity but a real pleasure. As far as I know there is so called shopping therapy that helps people to reduce stress buying different goods or even just going window shopping."))
        
        data.append(Item(image: UIImage(named: "slideCard2")!, rating: nil, title: "Shopping", subtitle: "Describe all shopping thing", description: "It is difficult to imagine our life without shopping. On one hand, it’s one of quite important household tasks. Moreover, shopping is the way to get necessary food and clothes. So, if you don’t do it you can’t have all things which make your life so comfortable. On the other hand, it’s believed that for the vast majority of people going shopping is not just duty or necessity but a real pleasure. As far as I know there is so called shopping therapy that helps people to reduce stress buying different goods or even just going window shopping."))
        
        data.append(Item(image: UIImage(named: "slideCard3")!, rating: nil, title: "Shopping", subtitle: "Describe all shopping thing", description: "It is difficult to imagine our life without shopping. On one hand, it’s one of quite important household tasks. Moreover, shopping is the way to get necessary food and clothes. So, if you don’t do it you can’t have all things which make your life so comfortable. On the other hand, it’s believed that for the vast majority of people going shopping is not just duty or necessity but a real pleasure. As far as I know there is so called shopping therapy that helps people to reduce stress buying different goods or even just going window shopping."))
         
     }
    
    
}

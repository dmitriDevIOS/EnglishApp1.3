//
//  ViewController.swift
//  TinderLikeApp
//
//  Created by Dmitrii Timofeev on 21/05/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit

class QuizController: UIViewController {
    
//MARK: Properties
    
    let cardsDeckView = UIView()
    let bottomStackView = HomeButtonControllsStackView()
    
    let cardViewModels: [CardViewModel] = {
           let producers = [
               Advertiser(title: "Make America Great Again", brandName: "Donald Tramp", posterPhotoNames: ["dictBackground"]),
               QuizWordCard(word: "Make", pronunciation: "meik", definition: "To do something that can be done by hands", wordImages: ["2323", "2325", "2326"]),
               QuizWordCard(word: "Car", pronunciation: "kar", definition: "A vehicle that has four tires and can drive very fast", wordImages: ["2324", "2327"])
               ] as [ProducesCardViewModel]
           
           let viewModels = producers.map({return $0.toCardViewModel()})
           return viewModels
       }()
    
    //MARK: UI Properties
    
    let closeQuizButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.titleEdgeInsets  =  UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.setTitle("c  l  o  s  e    q  u  i  z", for: .normal)
        button.tintColor = .lightGreenFocus
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .light)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleCloseQuize), for: .touchUpInside)
        return button
    }()
    
        //MARK: --------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupDummyCards()
    }
    
     //MARK: status bar hidden
     
     override var prefersStatusBarHidden: Bool {
         return true
     }
     
    
    
    //MARK: Setup UI / Layout

    
    fileprivate func setupLayout() {
        
      //  view.setGradientBackground(colorOne: .lightGreenFocus, colorTwo: .black)
        view.backgroundColor = .lightOrange
        
        let overallStackView = UIStackView(arrangedSubviews: [ cardsDeckView, bottomStackView])
        overallStackView.axis = .vertical
        cardsDeckView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 1.35  ).isActive = true
        view.addSubview(closeQuizButton)
        view.addSubview(overallStackView)
        
        overallStackView.anchor(top: closeQuizButton.bottomAnchor , leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        
        closeQuizButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: overallStackView.topAnchor, trailing: view.trailingAnchor)
        
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
        overallStackView.bringSubviewToFront(cardsDeckView)
        
        view.bringSubviewToFront(overallStackView)
        
        
        
    }
    
   //MARK: Target functions
    
    @objc private func handleCloseQuize() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    private func  setupDummyCards() {
        
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardVM
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
            
        }
    }
    
    
}


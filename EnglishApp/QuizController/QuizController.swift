//
//  ViewController.swift
//  TinderLikeApp
//
//  Created by Dmitrii Timofeev on 21/05/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit

class QuizController: UIViewController {

    
    let closeQuizButton : UIButton = {
        
        let button = UIButton(type: .system)
        
        button.backgroundColor = .white
        button.titleEdgeInsets  =  UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.setTitle("close quiz", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 42)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        
        button.addTarget(self, action: #selector(handleCloseQuize), for: .touchUpInside)
        return button
    }()
    
    let cardsDeckView = UIView()
    let bottomStackView = HomeButtonControllsStackView()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
        setupLayout()
        
        setupDummyCards()
        
        
    }

    
    @objc private func handleCloseQuize() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //MARK: Setup UI / Layout
    
    
    private func setupDummyCards() {
        
       // (0..<10).forEach { (_) in
            let cardView = CardView(frame: .zero)
                   cardsDeckView.addSubview(cardView)
                   cardView.fillSuperview()
     //   }
        
       
    }
    
    fileprivate func setupLayout() {
        
        view.backgroundColor = .white
        
        let overallStackView = UIStackView(arrangedSubviews: [ cardsDeckView, bottomStackView])
                 overallStackView.axis = .vertical
                 
        view.addSubview(overallStackView)
        view.addSubview(closeQuizButton)
        
        
        closeQuizButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: overallStackView.topAnchor, trailing: view.trailingAnchor)
      
         
        overallStackView.anchor(top: closeQuizButton.bottomAnchor , leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
        overallStackView.bringSubviewToFront(cardsDeckView)
        
        view.bringSubviewToFront(overallStackView)
        
        
      }
    

}


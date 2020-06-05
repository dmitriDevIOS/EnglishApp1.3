//
//  MediaController.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 18/05/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit


class CardsController : UIViewController {
    
    let wordLabel : UILabel = {
             let label = UILabel()
             label.translatesAutoresizingMaskIntoConstraints = false
             label.text = "WORD"
             label.font  = UIFont.boldSystemFont(ofSize: 65)
        label.backgroundColor = .orange
       label.clipsToBounds = true
        label.layer.cornerRadius  = 20
        label.applyShadows()
              label.textAlignment = .center
             label.textColor = .black
             return label
              
         }()
      
      
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    
        view.addSubview(wordLabel)
              
        wordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        wordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -30).isActive = true
        wordLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -200).isActive  = true
              wordLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
    }
    
    

    
}

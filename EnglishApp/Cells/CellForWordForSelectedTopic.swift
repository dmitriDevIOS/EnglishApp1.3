//
//  CellForWordForSelectedTopic.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 06/06/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//
//


import UIKit

class CellForWordForSelectedTopic : UICollectionViewCell {
    
  
    
    let wordImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "2325"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
       // imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    
    let wordLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "WordWordWord"
        label.font  =  UIFont.systemFont(ofSize: 34, weight: .light)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    let pronunciationLabel : UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.text = "pronunciation"
        label.font  =  UIFont.systemFont(ofSize: 16, weight: .light)
           label.textColor = .lightGray
        label.textAlignment = .center
           return label
       }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(wordImageView)
        addSubview(wordLabel)
        addSubview(pronunciationLabel)
        
        
        wordImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        wordImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        wordImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        wordImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        
        let height = (UIScreen.main.bounds.width - (3 * 8)) / 7
        
        wordLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        wordLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        wordLabel.trailingAnchor.constraint(equalTo: wordImageView.leadingAnchor).isActive = true
        wordLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        pronunciationLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor).isActive = true
        pronunciationLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        pronunciationLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        pronunciationLabel.trailingAnchor.constraint(equalTo: wordImageView.leadingAnchor).isActive = true
 
        
        
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


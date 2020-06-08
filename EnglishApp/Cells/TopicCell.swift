//
//  Cells.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 20/05/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit

class TopicCell : UICollectionViewCell {
    
    let randomColorsForBottom : [UIColor] = [.darkOrange, .darkAmber, .darkLightGreen, .darkPurple, .darkLightPink, .darkRed, .darkIndigo, .darkYellow]
    let randomColorForHeader : [UIColor] = [.lightOrange, .lightAmber, .lightLightGreen, .lightPurple, .lightLightPink, .lightRed, .lightIndigo, .lightYellow]
    
    var topicImageName: String?
    
    var topic : String? {
        didSet{
            
            let randomNumber = Int.random(in: 0 ..< randomColorsForBottom.count)
            topicLabel.text = topic
            topicImageView.image = UIImage(named: topicImageName!)
            setGradientBackground(colorOne: randomColorsForBottom[randomNumber], colorTwo: randomColorForHeader[randomNumber])
        }
    }
    
    let topicImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "2325"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    
    let topicLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "WordWordWord"
        label.font  =  UIFont.systemFont(ofSize: 24, weight: .light)
        label.textColor = .white
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        addSubview(topicImageView)
        topicImageView.rightAnchor.constraint(equalTo: rightAnchor, constant:  -10).isActive = true
        topicImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5).isActive = true
        topicImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        topicImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        topicImageView.transform = CGAffineTransform(rotationAngle: 120)
        
        addSubview(topicLabel)
        topicLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        topicLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topicLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        topicLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        
        
        
        
    }
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

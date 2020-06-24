//
//  HomeButtonControllsStackView.swift
//  TinderLikeApp
//
//  Created by Dmitrii Timofeev on 21/05/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit

class HomeButtonControllsStackView: UIStackView {
    
    
    
    override init(frame: CGRect) { 
        super.init(frame: frame)
        
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let buttonSubViews = [#imageLiteral(resourceName: "03_1.png"),#imageLiteral(resourceName: "03_2.png"),#imageLiteral(resourceName: "03_3.png"),#imageLiteral(resourceName: "03_4.png"),#imageLiteral(resourceName: "03_5.png")].map { (img) -> UIView in
            let button = UIButton(type: .system)
            button.setImage(img.withRenderingMode(.alwaysOriginal ), for: .normal)
            return button
        }
        
        buttonSubViews.forEach { (v) in
            addArrangedSubview(v)
        }
        

    }
    
    
    required init(coder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
    
    
}

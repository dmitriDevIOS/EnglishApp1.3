//
//  UIViewExtenstion.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 25/05/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//


import UIKit

extension UIView {
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradientBackgroundWithManyColors(colorOne: UIColor, colorTwo: UIColor, colorThree: UIColor, colorFour: UIColor ,colorFive: UIColor ,colorSix: UIColor ) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor, colorThree.cgColor, colorFour.cgColor, colorFive.cgColor, colorSix.cgColor]
        gradientLayer.locations = [0.0,  0.2 ,0.4 , 0.6, 0.8 , 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func applyShadows() {
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 15, height: 15)
        
    }
    
    
}


extension UIView {
    
    @discardableResult
    func corners(_ radius: CGFloat) -> UIView {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func shadow(radius: CGFloat, color: UIColor, offset: CGSize, opacity: Float) -> UIView {
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        return self
    }
    
}

class SCView: UIView {
    
    init(radius: CGFloat, color: UIColor, offset: CGSize, opacity: Float, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        layer.shadowRadius = radius
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        layer.masksToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class SCImageView: UIView {
    init(_ imageView: UIImageView, radius: CGFloat, color: UIColor, offset: CGSize, opacity: Float, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        layer.shadowRadius = radius
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        layer.masksToBounds = false
        
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SCButtonView: UIView {
    init(_ button: UIButton, radius: CGFloat, color: UIColor, offset: CGSize, opacity: Float, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        layer.shadowRadius = radius
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        layer.masksToBounds = false
        
        button.layer.cornerRadius = cornerRadius
        button.clipsToBounds = true
        addSubview(button)
        button.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




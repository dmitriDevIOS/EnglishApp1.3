//
//  CardView.swift
//  TinderLikeApp
//
//  Created by Dmitrii Timofeev on 21/05/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    fileprivate let imageView = UIImageView.init(image: UIImage(named: "2323"))
    
    private let threshold: CGFloat = 100
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        layer.cornerRadius = 20
        clipsToBounds = true
        
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
        
        
        
    }
    
    
    
    @objc  private func handlePan(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .changed:
            handleChangedPanState(gesture)
        case .ended:
            handleEndedPanState(gesture)
        default:
            ()
        }
        
    }
    
    
    fileprivate func handleChangedPanState(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        // rotation
        // convert radians to degrees
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
        
        
        //
        //          self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
    }
    
    fileprivate func handleEndedPanState(_ gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold
        
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard {
                let offScreenTransform = self.transform.translatedBy(x: 400 * translationDirection, y: 0)
                self.transform =  offScreenTransform
                
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (Timer) in
                    self.imageView.image = UIImage(named: "dictBackground")!
                    self.imageView.alpha = 0.0
                }
                
            } else {
                self.transform = .identity
            }
            
        }) { (_) in
            self.transform = .identity
          //   self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
            UIView.animate(withDuration: 0.1, animations: {
                   self.imageView.alpha = 1.0
               }, completion: nil)
            
        }
    }
    
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}

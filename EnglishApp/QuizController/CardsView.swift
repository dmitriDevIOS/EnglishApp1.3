//
//  CardView.swift
//  TinderLikeApp
//
//  Created by Dmitrii Timofeev on 21/05/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    var cardViewModel: CardViewModel! {
        didSet{
            
            imageView.image = UIImage(named: cardViewModel.imageNames.first ?? "")
            informationLabel.attributedText = cardViewModel.attributedString
            informationLabel.textAlignment = cardViewModel.textAlignment
            
            (0..<cardViewModel.imageNames.count ).forEach { (_) in
         
                let barView = UIView()
                barView.backgroundColor = UIColor(white: 0, alpha: 0.1)
                barsStackView.addArrangedSubview(barView)
            }
            
              barsStackView.arrangedSubviews.first?.backgroundColor = .white
            
            if cardViewModel.imageNames.count == 1 {
                         barsStackView.alpha = 0
                     }

        }
    }
    
    fileprivate  let imageView = UIImageView()
    fileprivate let gradientLayer = CAGradientLayer()
    fileprivate  let informationLabel = UILabel()
    
    private let threshold: CGFloat = 100
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
        
    }
    
    
    override func layoutSubviews() {
        // in here you know what your CardView frame will be
        gradientLayer.frame = self.frame
    }
    
    
    
    @objc  private func handlePan(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            superview?.subviews.forEach({ (subView) in
                subView.layer.removeAllAnimations()
            })
        case .changed:
            handleChangedPanState(gesture)
        case .ended:
            handleEndedPanState(gesture)
        default:
            ()
        }
        
    }
    
    
    var imageIndex = 0
    
    @objc private func handleTapGesture(gesture: UIGestureRecognizer) {
        
        print("handle tapping")
        
        let tapLocation = gesture.location(in: nil)
        let shouldAdvanceNextPhoto = tapLocation.x > frame.width / 2 ? true : false
        if shouldAdvanceNextPhoto {
            imageIndex = min(imageIndex + 1, cardViewModel.imageNames.count - 1 )
        } else {
            imageIndex = max(0, imageIndex - 1)
        }
        
        let imageName = cardViewModel.imageNames[imageIndex]
        imageView.image = UIImage(named: imageName)
        barsStackView.arrangedSubviews.forEach { (v) in
        v.backgroundColor = UIColor(white: 0, alpha: 0.1)
        }
        barsStackView.arrangedSubviews[imageIndex].backgroundColor = .white
        
    }
    
    fileprivate func setupLayout() {
        layer.cornerRadius = 20
        clipsToBounds = true
        
        
        
        
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()
        
        setupBarStackView()
        
        
        // add a gradient layer
        setupGradientLayer()
        
        // add info label
        addSubview(informationLabel)
        informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        
        
        informationLabel.textColor = .white
        informationLabel.numberOfLines = 0
    }
    
    fileprivate let barsStackView = UIStackView()
    
    fileprivate func setupBarStackView() {
        
        addSubview(barsStackView)
        
        barsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 4))
        barsStackView.spacing = 4
        barsStackView.distribution = .fillEqually
        
        
    }
    
    
    //  fileprivate let gradientLayer = CAGradientLayer()
    
    fileprivate func setupGradientLayer() {
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.65,1]
        layer.addSublayer(gradientLayer)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
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
                
                //                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (Timer) in
                //                    self.imageView.image = UIImage(named: "dictBackground")!
                //                    self.imageView.alpha = 0.0
                //                }
                
            } else {
                self.transform = .identity
            }
            
        }) { (_) in
            // self.transform = .identity
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

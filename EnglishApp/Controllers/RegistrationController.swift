//
//  RegistrationController.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 08/06/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {
    
    let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system )
        button.setTitle("Select photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor  = .white
        button.setTitleColor(.black, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 275).isActive = true
        button.layer.cornerRadius = 20
        return button
    }()
    
    
    let fullNameTextField : CustomTextField = {
        let tf = CustomTextField(padding: 22)
        tf.placeholder = "Enter full name"
        tf.backgroundColor = .white
        return tf
    }()
    
    
    let emailTextField : CustomTextField = {
        let tf = CustomTextField(padding: 22)
        tf.placeholder = "Enter your email"
        tf.backgroundColor = .white
        
        return tf
    }()
    
    
    
    let passwordTextField : CustomTextField = {
        let tf = CustomTextField(padding: 22)
        tf.placeholder = "Enter password"
        tf.backgroundColor = .white
        
        return tf
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        
        setupLayout()
        
        setupNotificationObservers()
        
        setupTapGesture()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func setupNotificationObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
 
    fileprivate func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    @objc fileprivate func handleTapDismiss() {
        self.view.endEditing(true)
        
        UIView.animate(withDuration: 0.5, delay: 0.0,usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                 self.view.transform = .identity
        }, completion: nil)
   
    }
    
    @objc fileprivate func handleKeyboardHide()  {
        UIView.animate(withDuration: 0.5, delay: 0.0,usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                        self.view.transform = .identity
               }, completion: nil)
    }
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        print("show keyboard")
        
        // how to figure out how tall the keyboard actually is
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        print(keyboardFrame)
        
        // let's try to figure out how tall the gap is from the register button to the bottom of the screen
        let bottomSpace = view.frame.height  - stackView.frame.origin.y - stackView.frame.height
        print(bottomSpace)
        
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
    }
    
    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        let topColor = #colorLiteral(red: 0.9288001657, green: 0.1316194236, blue: 0.7599021196, alpha: 1)
        let bottomColor = #colorLiteral(red: 0, green: 0.6307321787, blue: 0.8752467036, alpha: 1)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
    
    lazy var stackView = UIStackView(arrangedSubviews: [
              selectPhotoButton,
              fullNameTextField,
              emailTextField,
              passwordTextField
          ])
    
    fileprivate func setupLayout() {
        
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
}

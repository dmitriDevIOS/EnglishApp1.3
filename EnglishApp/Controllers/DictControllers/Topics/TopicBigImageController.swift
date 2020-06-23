//
//  TopicBigImageScrollView.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 08/06/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit

class TopicBigImageController : UIViewController {
    
    //MARK: DATA properties
    
    var imageName = String()
    
    //MARK: UI properties
    
    let closeControllerButton : UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .darkAmber
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 42)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.titleEdgeInsets = .init(top: 0, left: 0, bottom: 15, right: 0)
        button.addTarget(self, action: #selector(handleCloseVC), for: .touchUpInside)
        return button
    }()
    
    
    var imageScrollView: ImageScrollView!
    
    //MARK: ================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageScrollView()
    
    }
    

    func setupImageScrollView() {
        
        imageScrollView = ImageScrollView(frame: view.bounds)
        let image = UIImage(named: imageName)!
        self.imageScrollView.set(image: image)
        
        view.backgroundColor = .black
        
        view.addSubview(imageScrollView)
        view.addSubview(closeControllerButton)
        
        closeControllerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        closeControllerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        closeControllerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        closeControllerButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageScrollView.bottomAnchor.constraint(equalTo: closeControllerButton.topAnchor).isActive = true
        imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc private func handleCloseVC() {
        dismiss(animated: true, completion: nil)
    }
    
    
}

//
//  TopicsWordController.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 21/05/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit

class TopicsWordController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let topicImageNames = ["weatherTopicImage", "measurementTopicImage", "timeTopicImage", "calendarTopicImage",     "shoppingTopicImage",
    "studyingTopicImage",
    "schoolTopicImage",
    "describeThingsTopicImage",
    "colorsTopicImage",
    "familyTopicImage",
    "feelingsTopicImage",
    "homeTopicImage",
    "kitchenTopicImage"]
    
    let topics = ["weather",
    "measurements",
    "time",
    "calendar",
    "shopping",
    "studying",
    "school",
    "describe things",
    "colors",
    "family",
    "feelings",
    "home",
    "kitchen"
    ]
    
    
    let titleLable : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Topics"
        label.font  = UIFont.boldSystemFont(ofSize: 65)
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        return label
        
    }()
    
 
    
    let topicsCollectionView : UICollectionView = {
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 400, height: 800), collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topicsCollectionView.delegate = self
        topicsCollectionView.dataSource = self
        topicsCollectionView.register(TopicCell.self, forCellWithReuseIdentifier: "TopicCell")
        
        
        
        setupUI()
        
        
        
    }
    
    
  
    private func setupUI() {
        
        view.setGradientBackground(colorOne: .greenBlueSea, colorTwo: .black)
        
        view.addSubview(titleLable)
        
        
        titleLable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        titleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLable.heightAnchor.constraint(equalToConstant: 100).isActive = true
        titleLable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(topicsCollectionView)
        
        topicsCollectionView.topAnchor.constraint(equalTo: titleLable.bottomAnchor).isActive = true
        topicsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topicsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        topicsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        

        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopicCell", for: indexPath) as! TopicCell
        
    
        cell.clipsToBounds = true
     //   cell.setGradientBackground(colorOne: .lightGreen, colorTwo: .almostGrey)
        cell.layer.cornerRadius = 15
        cell.topicImageName = topicImageNames[indexPath.item]
        cell.topic = topics[indexPath.item]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - (3 * 16)) / 2
        
        return CGSize(width: width, height: width / 2 + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let topicWordsController = SelectedTopicController()
        topicWordsController.modalPresentationStyle = .automatic
        present(topicWordsController, animated:  true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

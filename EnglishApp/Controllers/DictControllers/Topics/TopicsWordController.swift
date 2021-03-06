//
//  TopicsWordController.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 21/05/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit

class TopicsWordController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: DATA properties
    
    var allTopics = [Topic]()
    let notification = Notifications() // тестировал локальные уведомления
    
    //MARK: UI properties
    
    let titleLable : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "T O P I C S"
        label.font  =  UIFont.systemFont(ofSize: 45, weight: .light)
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
        
        tableViewDelegateDataSourceCell()
        setupUI()
        fillTopicData()
        
    }
    
    private func tableViewDelegateDataSourceCell() {
        topicsCollectionView.delegate = self
        topicsCollectionView.dataSource = self
        topicsCollectionView.register(TopicCell.self, forCellWithReuseIdentifier: "TopicCell")
    }
    
    private func fillTopicData() {
        
        for index in (0..<topics.count) {
            let topic = Topic(topicName: topics[index], topicImageName: topicImageNames[index], topicWords: topicWordsArray[index], topicBigImageName: topicBigImageNames[index])
            allTopics.append(topic)
        }
        
    }
    
    
    private func setupUI() {
        
        let randomNumber = Int.random(in: 0 ..< randomColorForHeader.count)
        view.setGradientBackground(colorOne: randomColorForHeader[randomNumber], colorTwo: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))
        
        view.addSubview(titleLable)
        titleLable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        titleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLable.heightAnchor.constraint(equalToConstant: 80).isActive = true
        titleLable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        view.addSubview(topicsCollectionView)
        topicsCollectionView.topAnchor.constraint(equalTo: titleLable.bottomAnchor).isActive = true
        topicsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topicsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        topicsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
    
    //MARK: CollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopicCell", for: indexPath) as! TopicCell
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 15
        cell.topicImageName = allTopics[indexPath.item].topicImageName
        cell.topic = allTopics[indexPath.item].topicName
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
        
        notification.scheduledNotification(notificationType: "5 Seconds Notification")
        
        let topicWordsController = SelectedTopicController()
        topicWordsController.selectedTopic = allTopics[indexPath.item]
        let randomNumber1 = Int.random(in: 0 ..< randomColorsForBottom.count)
        let randomNumber2 = Int.random(in: 0 ..< randomColorsForBottom.count)
        
        topicWordsController.view.setGradientBackground(colorOne: randomColorsForBottom[randomNumber1], colorTwo: randomColorForHeader[randomNumber2])
        topicWordsController.modalPresentationStyle = .automatic
        present(topicWordsController, animated:  true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    //MARK: - Ramdomness of color
    
    let randomColorsForBottom : [UIColor] = [.darkOrange, .darkAmber, .darkLightGreen, .darkPurple, .darkLightPink, .darkRed, .darkIndigo, .darkYellow]
    let randomColorForHeader : [UIColor] = [.lightOrange, .lightAmber, .lightLightGreen, .lightPurple, .lightLightPink, .lightRed, .lightIndigo, .lightYellow]
    
    // MARK: - TOPICS FAKE DATA
    
    let topicImageNames = [
        "weatherTopicImage",
        "measurementTopicImage",
        "timeTopicImage",
        "calendarTopicImage",
        "shoppingTopicImage",
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
    
    let topicBigImageNames = [
        "weatherBigImage",
        "weatherBigImage",
        "weatherBigImage",
        "weatherBigImage",
        "weatherBigImage",
        "weatherBigImage",
        "weatherBigImage",
        "weatherBigImage",
        "weatherBigImage",
        "weatherBigImage",
        "weatherBigImage",
        "weatherBigImage",
        "weatherBigImage",
        
    ]
    
    let topicWordsArray = [
        [
            Word(word: "fahrenheit",wordImage: "2323", transcript: "ˈfærənhaɪt"),
            Word(word: "celsius",wordImage: "2324", transcript: "ˈselsiəs"),
            Word(word: "hot",wordImage: "2325", transcript: "hɒt"),
            Word(word: "warm",wordImage: "2326", transcript: "wɔːm"),
            Word(word: "cool",wordImage: "2323", transcript: "kuːl"),
            Word(word: "cold",wordImage: "2324", transcript: "kəʊld"),
            Word(word: "freezing",wordImage: "2325", transcript: "freezing"),
            Word(word: "degree",wordImage: "2323", transcript: "dɪˈɡriː"),
            Word(word: "sunny",wordImage: "2324", transcript: "ˈsʌni"),
            Word(word: "cloudy",wordImage: "2325", transcript: "ˈklaʊdi"),
            Word(word: "rain",wordImage: "2323", transcript: "reɪn"),
            Word(word: "snow",wordImage: "2324", transcript: "snəʊ"),
            Word(word: "heatwave",wordImage: "2325", transcript: "ˈhiːtweɪv"),
            Word(word: "smoggy",wordImage: "2323", transcript: "ˈsmɒɡi"),
            Word(word: "humid",wordImage: "2324", transcript: "ˈhjuːmɪd"),
            Word(word: "thunderstorm",wordImage: "2325", transcript: "ˈθʌndəstɔːm"),
            Word(word: "lightning",wordImage: "2323", transcript: "ˈlaɪtnɪŋ"),
            Word(word: "windy",wordImage: "2324", transcript: "ˈwɪndi"),
            Word(word: "dust storm",wordImage: "2325", transcript: "ˈdʌst stɔːm"),
            Word(word: "foggy",wordImage: "2323", transcript: "ˈfɒɡi"),
            Word(word: "hailstorm",wordImage: "2324", transcript: "ˈheɪlstɔːm"),
            Word(word: "icy",wordImage: "2325", transcript: "ˈaɪsi"),
            Word(word: "blizzard",wordImage: "2323", transcript: "ˈblɪzərd")
        ],
        
        
        
        [Word(word: "take"), Word(word: "take"), Word(word: "take"), Word(word: "take")],
        [Word(word: "take"), Word(word: "take"), Word(word: "take"), Word(word: "take")],
        [Word(word: "take"), Word(word: "take"), Word(word: "take"), Word(word: "take")],
        [Word(word: "take"), Word(word: "take"), Word(word: "take"), Word(word: "take")],
        [Word(word: "take"), Word(word: "take"), Word(word: "take"), Word(word: "take")],
        [Word(word: "take"), Word(word: "take"), Word(word: "take"), Word(word: "take")],
        [Word(word: "take"), Word(word: "take"), Word(word: "take"), Word(word: "take")],
        [Word(word: "take"), Word(word: "take"), Word(word: "take"), Word(word: "take")],
        [Word(word: "take"), Word(word: "take"), Word(word: "take"), Word(word: "take")],
        [Word(word: "take"), Word(word: "take"), Word(word: "take"), Word(word: "take")],
        [Word(word: "take"), Word(word: "take"), Word(word: "take"), Word(word: "take")],
        [Word(word: "take"), Word(word: "take"), Word(word: "take"), Word(word: "take")],
    ]
    
    
    
}

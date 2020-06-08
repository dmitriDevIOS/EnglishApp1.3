//
//  TopicsWordController.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 21/05/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit

class SelectedTopicController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    var selectedTopic: Topic! {
        didSet {
            titleLable.text = selectedTopic.topicName
        }
    }
    
    let titleLable : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Selected"
        label.font  =  UIFont.systemFont(ofSize: 45, weight: .light)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
        
    }()
    
    let quizButton : UIButton = {
        
        let button = UIButton(type: .system)
        
        button.backgroundColor = .clear
        button.titleEdgeInsets  =  UIEdgeInsets(top: 10, left: 10, bottom: 40, right: 10)
        button.setTitle("TAKE A QUIZ", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 36, weight: .light)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        
        button.addTarget(self, action: #selector(handleQuizButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    let wordsColletionView : UICollectionView = {
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 400, height: 800), collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordsColletionView.delegate = self
        wordsColletionView.dataSource = self
        wordsColletionView.register(CellForWordForSelectedTopic.self, forCellWithReuseIdentifier: "WordCell")
        
        
        
        setupUI()
        
        
        
    }
    
    
    @objc private func handleQuizButtonPressed() {

        let topicWordsController = QuizController()
         topicWordsController.modalPresentationStyle = .fullScreen
        present(topicWordsController, animated:  true)
        
        
    }
    
    
    private func setupUI() {
        
  //      view.setGradientBackground(colorOne: .superLightGreen, colorTwo: .lightGreenFocus)
        
        view.addSubview(titleLable)
        view.addSubview(wordsColletionView)
        view.addSubview(quizButton)
        
        titleLable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        titleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLable.heightAnchor.constraint(equalToConstant: 70).isActive = true
        titleLable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        wordsColletionView.topAnchor.constraint(equalTo: titleLable.bottomAnchor).isActive = true
        wordsColletionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        wordsColletionView.bottomAnchor.constraint(equalTo: quizButton.topAnchor).isActive = true
        wordsColletionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        quizButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        quizButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        quizButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        quizButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedTopic?.topicWords.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WordCell", for: indexPath) as! CellForWordForSelectedTopic
        
        cell.setGradientBackground(colorOne: .white, colorTwo: .lightPurpleColor)
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 15
        cell.wordLabel.text = selectedTopic.topicWords[indexPath.item].word
        cell.wordImageView.image = UIImage(named: selectedTopic.topicWords[indexPath.item].wordImage ?? "2323")
        cell.pronunciationLabel.text = selectedTopic.topicWords[indexPath.item].transcript ?? "transcript"
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (UIScreen.main.bounds.width - (3 * 8)) // / 2
        
        return CGSize(width: width, height: width / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
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

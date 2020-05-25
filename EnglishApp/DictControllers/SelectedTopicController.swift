//
//  TopicsWordController.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 21/05/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit

class SelectedTopicController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let titleLable : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Selected"
        label.font  = UIFont.boldSystemFont(ofSize: 65)
        label.textAlignment = .center
        label.textColor = .black
        return label
        
    }()
    
    let quizButton : UIButton = {
        
        let button = UIButton(type: .system)
        
        button.backgroundColor = .greenBlueSea
        button.titleEdgeInsets  =  UIEdgeInsets(top: 10, left: 10, bottom: 40, right: 10)
        button.setTitle("Take a quiz", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 42)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        
        button.addTarget(self, action: #selector(handleQuizButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    let wordsColletionView : UICollectionView = {
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 400, height: 800), collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .lightGreen
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordsColletionView.delegate = self
        wordsColletionView.dataSource = self
        wordsColletionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        setupUI()
        
        
        
    }
    
    
    @objc private func handleQuizButtonPressed() {
        
        
        let topicWordsController = QuizController()
         topicWordsController.modalPresentationStyle = .fullScreen
        present(topicWordsController, animated:  true)
        
        
    }
    
    
    private func setupUI() {
        
        view.backgroundColor = .lightGreen
        
        view.addSubview(titleLable)
        view.addSubview(wordsColletionView)
        view.addSubview(quizButton)
        
        titleLable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        titleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLable.heightAnchor.constraint(equalToConstant: 100).isActive = true
        titleLable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        wordsColletionView.topAnchor.constraint(equalTo: titleLable.bottomAnchor).isActive = true
        wordsColletionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        wordsColletionView.bottomAnchor.constraint(equalTo: quizButton.topAnchor).isActive = true
        wordsColletionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        quizButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        quizButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        quizButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        quizButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        cell.backgroundColor = .darkGreen
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 10
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - (3 * 8)) // / 2
        
        return CGSize(width: width, height: width / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //
        //        let topicWordsController = TopicsWordController()
        //        topicWordsController.modalPresentationStyle = .automatic
        //        present(topicWordsController, animated:  true)
        
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

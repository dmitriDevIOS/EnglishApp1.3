//
//  SelectedWordController.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 16/06/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit

class SelectedWordController : UIViewController {
    
    var word : WordRealmModel! {
        didSet{
            title = word.word
            
            let anotherColorAttribute = [ NSAttributedString.Key.backgroundColor: UIColor.lightGreen ]
            
            partOfSpeechLabel.text  = word.partOfSpeech
            
            let attributedTextForDefinition = NSMutableAttributedString(string: "Definition: ", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .light)])
            attributedTextForDefinition.addAttributes(anotherColorAttribute, range: NSRange(location: 0, length: 11))
            attributedTextForDefinition.append(NSAttributedString(string: word.definition ?? "", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .regular)]))
            definitionLabel.attributedText = attributedTextForDefinition
            
            
            let attributedTextForPronunciation = NSMutableAttributedString(string: "Transcript: ", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .light)])
            attributedTextForPronunciation.addAttributes(anotherColorAttribute, range: NSRange(location: 0, length: 11))
            attributedTextForPronunciation.append(NSAttributedString(string: word.pronunciation ?? "", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .regular)]))
            pronunciationLabel.attributedText = attributedTextForPronunciation
            
            
            
            let attributedText = NSMutableAttributedString(string: "Example:     ", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .light)])
            attributedText.addAttributes(anotherColorAttribute, range: NSRange(location: 0, length: 12))
            attributedText.append(NSAttributedString(string: word.examples ?? "", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .regular)]))
            examplesLabel.attributedText = attributedText
            
            
            
            let attributedTextForSynonyms = NSMutableAttributedString(string: "Synonyms:  ", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .light)])
            attributedTextForSynonyms.addAttributes(anotherColorAttribute, range: NSRange(location: 0, length: 10))
            attributedTextForSynonyms.append(NSAttributedString(string: word.synontms ?? "", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .regular)]))
            
            synonymsLabel.attributedText = attributedTextForSynonyms
            
            
            
            
            let attributedTextForAntonyms = NSMutableAttributedString(string: "Antonyms:   ", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .light)])
            attributedTextForAntonyms.addAttributes(anotherColorAttribute, range: NSRange(location: 0, length: 10))
            attributedTextForAntonyms.append(NSAttributedString(string: word.antonyms ?? "", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .regular)]))
            
            antonymsLabel.attributedText = attributedTextForAntonyms
            
            if let image = word.image {
                wordImageView.image = UIImage(data: image)
            }
            
            
            germanTranslationLabel.text = "DE: \(word.germanTranslation ?? "")"
            russianTranslationLabel.text =  "RU: \(word.russianTranslation ?? "")"
            polishTranslationLabel.text = "PL: \(word.polishTranslation ?? "")"
            hebrewTranslationLabel.text = "IW: \(word.hebrewTranslation ?? "")"
            
            
        }
    }
    
    
    let wordImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "noPicture"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    
    
    
    let definitionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Definition: "
        label.font  = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .black
        return label
    }()
    
    let partOfSpeechLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Noun"
        label.font  = UIFont.italicSystemFont(ofSize: 16)
        label.textColor = .darkGray
        label.setGradientBackground(colorOne: .lightIndigo, colorTwo: .darkIndigo)
        label.backgroundColor = .lightIndigo
        label.textAlignment = .center
        return label
    }()
    
    let synonymsLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Synonyms: Synonyms, Synonyms, Synonyms"
        label.font  = UIFont.systemFont(ofSize: 16, weight: .light)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let pronunciationLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pronunciation"
        label.font  = UIFont.systemFont(ofSize: 16, weight: .light)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let antonymsLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Antonyms: Antonyms, Antonyms, Antonyms"
        label.font  = UIFont.systemFont(ofSize: 16, weight: .light)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let examplesLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Examples: You can make an extension and parameterize the stride and the separator so that you can use it for every value you want (In my case, I use it to dump 32-bit space-operated hexadecimal data)"
        label.font  = UIFont.systemFont(ofSize: 16, weight: .light)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let germanTranslationLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "DE: "
        label.font  = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .natural
        label.textColor = .black
        return label
        
    }()
    
    let polishTranslationLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PL: "
        label.font  = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .natural
        label.textColor = .black
        return label
        
    }()
    
    let russianTranslationLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "RU: "
        label.font  = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .natural
        label.textColor = .black
        return label
        
    }()
    
    let hebrewTranslationLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "IW: "
        label.font  = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .natural
        label.textColor = .black
        return label
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(handleEditWord))
        
        view.setGradientBackground(colorOne: .lightAmber, colorTwo: .cyan)
        view.addSubview(pronunciationLabel)
        view.addSubview(partOfSpeechLabel)
        view.addSubview(definitionLabel)
        view.addSubview(synonymsLabel)
        view.addSubview(antonymsLabel)
        view.addSubview(examplesLabel)
        view.addSubview(wordImageView)
        view.addSubview(germanTranslationLabel)
        view.addSubview(hebrewTranslationLabel)
        view.addSubview(russianTranslationLabel)
        view.addSubview(polishTranslationLabel)
        
        
        partOfSpeechLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        partOfSpeechLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        partOfSpeechLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        partOfSpeechLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        pronunciationLabel.topAnchor.constraint(equalTo: partOfSpeechLabel.bottomAnchor, constant: 15).isActive = true
        pronunciationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        pronunciationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        
        definitionLabel.topAnchor.constraint(equalTo: pronunciationLabel.bottomAnchor, constant:  15).isActive = true
        definitionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        definitionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        // definitionLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        examplesLabel.topAnchor.constraint(equalTo: definitionLabel.bottomAnchor, constant:  15).isActive = true
        examplesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        examplesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        //   examplesLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        synonymsLabel.topAnchor.constraint(equalTo: examplesLabel.bottomAnchor, constant:  15).isActive = true
        synonymsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        synonymsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        //  synonymsLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        antonymsLabel.topAnchor.constraint(equalTo: synonymsLabel.bottomAnchor, constant:  15).isActive = true
        antonymsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        antonymsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        //   antonymsLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        wordImageView.topAnchor.constraint(equalTo: antonymsLabel.bottomAnchor, constant: 15).isActive = true
        wordImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        wordImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        wordImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        russianTranslationLabel.topAnchor.constraint(equalTo: wordImageView.bottomAnchor, constant: 10).isActive = true
        russianTranslationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        russianTranslationLabel.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        russianTranslationLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        germanTranslationLabel.topAnchor.constraint(equalTo: wordImageView.bottomAnchor, constant: 10).isActive = true
        germanTranslationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        germanTranslationLabel.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        germanTranslationLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        polishTranslationLabel.topAnchor.constraint(equalTo: russianTranslationLabel.bottomAnchor).isActive = true
        polishTranslationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        polishTranslationLabel.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        polishTranslationLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        hebrewTranslationLabel.topAnchor.constraint(equalTo: germanTranslationLabel.bottomAnchor).isActive = true
        hebrewTranslationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        hebrewTranslationLabel.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        hebrewTranslationLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        
    }
    
    
    @objc fileprivate func handleEditWord() {
        
        let editCompanyController = CreateNewWordController()
                   editCompanyController.word = word
                   editCompanyController.isEditingWord = true
                   self.navigationController?.pushViewController(editCompanyController, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        word = StorageManager.shared.searchForAWord(word: title ?? "")[0]
        
    }
    
    
}

//
//  DetailedWordCell.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 07/06/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit

class DetailedWordCell : UITableViewCell {
    
    var word : WordInfo? {
        didSet{
            
            let anotherColorAttribute = [ NSAttributedString.Key.backgroundColor: UIColor.lightGreen ]
            
            partOfSpeechLabel.text  = word?.partOfSpeech
            
            let attributedTextForDefinition = NSMutableAttributedString(string: "Definition: ", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .light)])
            attributedTextForDefinition.addAttributes(anotherColorAttribute, range: NSRange(location: 0, length: 11))
            attributedTextForDefinition.append(NSAttributedString(string: word?.definition ?? "", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .regular)]))
            definitionLabel.attributedText = attributedTextForDefinition
            
            
            var examples = String()
            word?.examples?.forEach({ (example) in
                examples.append(example!)
                examples.append(". ")
            })
            let attributedText = NSMutableAttributedString(string: "Example:     ", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .light)])
            attributedText.addAttributes(anotherColorAttribute, range: NSRange(location: 0, length: 12))
            attributedText.append(NSAttributedString(string: examples, attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .regular)]))
            examplesLabel.attributedText = attributedText
            
            
            var synonyms = String()
            word?.synonyms?.forEach({ (syn) in
                synonyms.append(syn!)
                synonyms.append(" | ")
            })
            
            
            let attributedTextForSynonyms = NSMutableAttributedString(string: "Synonyms:  ", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .light)])
            attributedTextForSynonyms.addAttributes(anotherColorAttribute, range: NSRange(location: 0, length: 10))
            attributedTextForSynonyms.append(NSAttributedString(string: synonyms, attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .regular)]))
            
            synonymsLabel.attributedText = attributedTextForSynonyms
            
            
            var antonyms = String()
            word?.antonyms?.forEach({ (ant) in
                antonyms.append(ant!)
                antonyms.append(" | ")
            })
            
            let attributedTextForAntonyms = NSMutableAttributedString(string: "Antonyms:   ", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .light)])
            attributedTextForAntonyms.addAttributes(anotherColorAttribute, range: NSRange(location: 0, length: 10))
            attributedTextForAntonyms.append(NSAttributedString(string: antonyms, attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .regular)]))
            
            antonymsLabel.attributedText = attributedTextForAntonyms
            
            
            
        }
    }
    
    
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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        addSubview(partOfSpeechLabel)
        addSubview(definitionLabel)
        addSubview(synonymsLabel)
        addSubview(antonymsLabel)
        addSubview(examplesLabel)
        
        
        partOfSpeechLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        partOfSpeechLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        partOfSpeechLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        partOfSpeechLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        definitionLabel.topAnchor.constraint(equalTo: partOfSpeechLabel.bottomAnchor).isActive = true
        definitionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        definitionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        definitionLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        examplesLabel.topAnchor.constraint(equalTo: definitionLabel.bottomAnchor).isActive = true
        examplesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        examplesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        examplesLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        synonymsLabel.topAnchor.constraint(equalTo: examplesLabel.bottomAnchor).isActive = true
        synonymsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        synonymsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        synonymsLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        antonymsLabel.topAnchor.constraint(equalTo: synonymsLabel.bottomAnchor).isActive = true
        antonymsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        antonymsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        antonymsLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

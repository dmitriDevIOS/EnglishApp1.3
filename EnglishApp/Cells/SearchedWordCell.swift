//
//  Cells.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 20/05/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit

class SearchedWordCell : UITableViewCell {
    
    var word : Word? {
        didSet{
            wordLabel.text = word?.word
            prononciationLabel.text = "(\(word?.pronunciation["all"] ?? ""))"
  
            
            if word?.results[0] == nil  {
                return
            } else {
                
                
                 var words = [String]()
                
                word?.results.forEach({ (result) in
                    result.synonyms?.forEach({ (syn) in
                        guard let syn = syn else { return }
                        words.append(syn)
                    })
                })
                
                if words.indices.contains(0) &&  words.indices.contains(1) && words.indices.contains(2)  {
                    synonymsLabel.text = "Synonyms: \(words[0]), \(words[1]), \(words[2])"
                } else if words.indices.contains(0) &&  words.indices.contains(1) {
                    synonymsLabel.text = "Synonyms: \(words[0]), \(words[1])"
                } else if words.indices.contains(0) {
                    synonymsLabel.text = "Synonyms: \(words[0])"
                } else {
                    synonymsLabel.text = "Synonyms: not found"
                }
            }
  
        }
    }
    
    let chevronSignImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")!
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .black
        
        return image
    }()
    
    let wordLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "WordWordWord"
        label.font  = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    let prononciationLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "(Prononciation)"
        label.font  = UIFont.italicSystemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()
    
    let synonymsLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Synonyms: Synonyms, Synonyms, Synonyms"
        label.font  = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        addSubview(wordLabel)
        wordLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        wordLabel.topAnchor.constraint(equalTo: topAnchor, constant: 7).isActive = true
        wordLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        wordLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(prononciationLabel)
        prononciationLabel.leftAnchor.constraint(equalTo: wordLabel.rightAnchor, constant: 20).isActive = true
        prononciationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 7).isActive = true
        prononciationLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        prononciationLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        addSubview(synonymsLabel)
        synonymsLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        synonymsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7).isActive = true
        synonymsLabel.widthAnchor.constraint(equalToConstant: 320).isActive = true
        synonymsLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(chevronSignImage)
        chevronSignImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        chevronSignImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        chevronSignImage.heightAnchor.constraint(equalToConstant: 15).isActive = true
        chevronSignImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

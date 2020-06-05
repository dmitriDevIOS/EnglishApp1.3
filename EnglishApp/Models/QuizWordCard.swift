//
//  QuizWordCard.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 05/06/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit

struct QuizWordCard : ProducesCardViewModel {
    
    let word: String
    let pronunciation: String
    let definition: String
    let wordImages: [String]
    
    
    func toCardViewModel() -> CardViewModel {
        
        let attributedText = NSMutableAttributedString(string: pronunciation, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        
        attributedText.append(NSAttributedString(string: " \(definition)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        
        return CardViewModel(imageNames: wordImages, attributedString: attributedText, textAlignment: .left)
    }
    
    
}

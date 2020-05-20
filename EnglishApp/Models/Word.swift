//
//  Word.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 18/05/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import Foundation




struct WordInfo: Decodable {
    
    var definition: String?
    var partOfSpeech: String?
    var synonyms: [String?]?
    var antonyms: [String?]?
    var examples: [String?]?
    
}

class Word : Decodable {
    
    var word : String?
    var frequency: Double? // higher number means that the word is used more frequently 
    var results: [WordInfo]
    var pronunciation : [String : String]
    
    init(word : String) {
        self.word = word
        self.frequency = 0.0
        self.results = [WordInfo(definition: "", partOfSpeech: "", synonyms: [""], antonyms: [""], examples: [""])]
        self.pronunciation = ["" : ""]
    }
    
    
}

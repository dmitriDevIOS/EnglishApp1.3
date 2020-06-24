//
//  Word.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 18/05/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import Foundation


class Word : NSObject, Decodable, NSCoding {
    
    var word : String
    var wordImage: String? 
    var frequency: Double? // higher number means that the word is used more frequently 
    var results: [WordInfo]
    var pronunciation : [String : String]
    var transcript : String?
    var ruTranslation : String?
    var deTranslation : String?
    var plTranslation : String?
    var iwTranslation : String?
    
    func encode(with coder: NSCoder) {
        
        
        coder.encode(word, forKey: "word")
        coder.encode(wordImage, forKey: "wordImage")
        coder.encode(frequency, forKey: "frequency")
        coder.encode(results, forKey: "results")
        coder.encode(pronunciation, forKey: "pronunciation")
        coder.encode(transcript, forKey: "transcript")
        coder.encode(ruTranslation, forKey: "ruTranslation")
        coder.encode(deTranslation, forKey: "deTranslation")
        coder.encode(plTranslation, forKey: "plTranslation")
        coder.encode(iwTranslation, forKey: "iwTranslation")
    }
    
    required init?(coder: NSCoder) {
       
        self.word = coder.decodeObject(forKey: "word") as? String ?? ""
        self.wordImage = coder.decodeObject(forKey: "wordImage") as? String ?? ""
        self.frequency = coder.decodeObject(forKey: "frequency") as? Double ?? 0.0
        self.results = coder.decodeObject(forKey: "results") as? [WordInfo] ?? [WordInfo(definition: "", partOfSpeech: "", synonyms: [""], antonyms: [""], examples: [""])]
        self.pronunciation = coder.decodeObject(forKey: "pronunciation") as? [String : String] ?? ["empty" : "empty"]
        self.transcript = coder.decodeObject(forKey: "transcript") as? String ?? ""
        self.ruTranslation = coder.decodeObject(forKey: "ruTranslation") as? String ?? ""
        self.deTranslation = coder.decodeObject(forKey: "deTranslation") as? String ?? ""
        self.plTranslation = coder.decodeObject(forKey: "plTranslation") as? String ?? ""
        self.iwTranslation = coder.decodeObject(forKey: "iwTranslation") as? String ?? ""
        
    }
    
    
    
    init(word : String) {
        self.wordImage = "noImage"
        self.word = word
        self.frequency = 0.0
        self.results = [WordInfo(definition: "", partOfSpeech: "", synonyms: [""], antonyms: [""], examples: [""])]
        self.pronunciation = ["" : ""]
        self.ruTranslation = ""
        self.plTranslation = ""
        self.deTranslation = ""
        self.iwTranslation = ""
    }
    
    
    init(word : String, wordImage: String, transcript: String) {
        self.transcript = transcript
        self.wordImage = wordImage
        self.word = word
        self.frequency = 0.0
        self.results = [WordInfo(definition: "", partOfSpeech: "", synonyms: [""], antonyms: [""], examples: [""])]
        self.pronunciation = ["" : ""]
        self.ruTranslation = ""
        self.plTranslation = ""
        self.deTranslation = ""
        self.iwTranslation = ""
    }
    
}


class WordInfo: NSObject, Decodable, NSCoding {
    
    var definition: String?
    var partOfSpeech: String?
    var synonyms: [String?]?
    var antonyms: [String?]?
    var examples: [String?]?
    
    
    init(definition: String, partOfSpeech: String, synonyms: [String], antonyms: [String], examples: [String]) {
        self.definition = definition
        self.partOfSpeech = partOfSpeech
        self.synonyms = synonyms
        self.antonyms = antonyms
        self.examples = examples
    }
    
    func encode(with coder: NSCoder) {
       
        
        coder.encode(definition, forKey: "definition")
        coder.encode(partOfSpeech, forKey: "partOfSpeech")
        coder.encode(synonyms, forKey: "synonyms")
        coder.encode(antonyms, forKey: "antonyms")
        coder.encode(examples, forKey: "examples")
    }
    
    required init?(coder: NSCoder) {
       
        
        self.definition = coder.decodeObject(forKey: "definition") as? String ?? ""
        self.partOfSpeech = coder.decodeObject(forKey: "partOfSpeech") as? String ?? ""
        self.synonyms = coder.decodeObject(forKey: "synonyms") as? [String] ?? [""]
        self.antonyms = coder.decodeObject(forKey: "antonyms") as? [String] ?? [""]
        self.examples = coder.decodeObject(forKey: "examples") as? [String] ?? [""]
    }
    
}

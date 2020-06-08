//
//  TranslatedWord.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 07/06/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import Foundation


struct TranslatedWord : Decodable{
    
    struct Data : Decodable{
        
        struct TranslatedText : Decodable{
            
           let translatedText : String
        }
        let translations : [TranslatedText]
    }
    let data : Data
}

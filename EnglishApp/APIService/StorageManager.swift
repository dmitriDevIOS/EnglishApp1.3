//
//  StorageManager.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 10/06/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import Foundation
import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    // Methods that save data to CoreData
    

    
    
    
    
    
    // Methods that save data to UserDefaults
    
    
    
    
     func saveSearchedWords(words: [Word]) {
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: words, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey:  "searchedWords")
        }
        
    }
    
     func fetchSearchedWords()  -> [Word]? {
        let defaults = UserDefaults.standard
        if let searchedWords = defaults.object(forKey: "searchedWords") as? Data {
            if let decodedSearchedWords = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(searchedWords) as? [Word] {
                return decodedSearchedWords
            }
            return nil
        }
        return nil
    }
    
    
    
}

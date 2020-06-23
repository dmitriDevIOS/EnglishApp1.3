//
//  StorageManager.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 10/06/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import Foundation
import RealmSwift



class StorageManager {
    
    static let shared = StorageManager()
    
    // Methods that save data to CoreData
    
    let realm = try! Realm()
    
    
    func saveNewCreatedWord(word: WordRealmModel) {
        
        //        realm.beginWrite()
        //        realm.add(word)
        //        try! realm.commitWrite()
        
        
        try! realm.write {
            realm.add(word)
        }
        
    }
    
    func deleteWord(word: String) -> Bool{
        
        
        let results = realm.objects(WordRealmModel.self).filter("word = '\(word)'")
        if results.isEmpty {
            print("no such word")
            return false
        } else {
            realm.beginWrite()
            realm.delete(results)
            try! realm.commitWrite()
            print("deleted")
            return true
        }
        
        
         
        
    }
    
    func searchForAWord(word: String) -> [WordRealmModel] {
        
        let results = realm.objects(WordRealmModel.self).filter("word = '\(word)'")
        
        if results.isEmpty {
            return [WordRealmModel]()
        } else {
            
            var finalResultArray = [WordRealmModel]()
            
            if results.isEmpty {
                print("no words in data base")
                return finalResultArray
            } else {
                
                results.forEach { (word) in
                    finalResultArray.append(word)
                }
                
                return finalResultArray
            }
        }
        
    }
    
    func checkIfWordExists(word: String) -> Bool {
        
        let results = realm.objects(WordRealmModel.self).filter("word = '\(word)'")
        
        if results.isEmpty {
            return true
        } else {
            return false
        }
        
    }
    
    
    
    func deleteAllYourWords() {
        
        let results = realm.objects(WordRealmModel.self)
        try! realm.write({
            realm.delete(results)
        })
        
    }
    
    
    func fetchYourWords() -> [WordRealmModel] {
        
        let results = realm.objects(WordRealmModel.self).sorted(byKeyPath: "word", ascending: true)
        
        var finalResultArray = [WordRealmModel]()
        
        if results.isEmpty {
            print("no words in data base")
            return finalResultArray
        } else {
            
            results.forEach { (word) in
                finalResultArray.append(word)
            }
            
            return finalResultArray
        }
        
        
        
        
    }
    
    
    
    
    
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

//
//  WordRealmModel.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 14/06/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import Foundation
import RealmSwift

class WordRealmModel : Object { // our class should be subclass of Object
    
    @objc dynamic var word : String?
    @objc dynamic var partOfSpeech: String?
    @objc dynamic var pronunciation: String?
    @objc dynamic var definition: String?
    @objc dynamic var antonyms: String?
    @objc dynamic var synontms: String?
    @objc dynamic var examples: String?
    @objc dynamic var image: Data?
    @objc dynamic var russianTranslation: String?
    @objc dynamic var polishTranslation: String?
    @objc dynamic var germanTranslation: String?
    @objc dynamic var hebrewTranslation: String?
    
    
}

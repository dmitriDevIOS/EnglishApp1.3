//
//  CardViewModel.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 05/06/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

class CardViewModel {
    
    // we will define properties that are view will display/render
    
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
   
    init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
        self.imageNames = imageNames
        self.attributedString = attributedString    
        self.textAlignment = textAlignment
    }
    
    
    
    
       
    fileprivate var imageIndex = 0 {
        didSet{
            let imageName = imageNames[imageIndex]
           let image = UIImage(named: imageName)
            imageIndexObserver?(imageIndex ,image)
        }
    }
    
    //MARK: - Reactive programming
    var imageIndexObserver: ((Int , UIImage?) -> ())?
    
     func advanceToNextPhoto() {
        imageIndex = min(imageIndex + 1, imageNames.count - 1)
    }
    
     func goToPreviousPhoto() {
        imageIndex = max(0, imageIndex - 1)
    }
    
}


// what exact do we do with this card view model thing?


 

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

struct CardViewModel {
    
    // we will define properties that are view will display/render
    
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    
}


// what exact do we do with this card view model thing?


 

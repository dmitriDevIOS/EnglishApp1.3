//
//  Advertiser.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 05/06/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit

struct Advertiser : ProducesCardViewModel {
    
    let title: String
    let brandName: String
    let posterPhotoNames: [String]
    
    func toCardViewModel() -> CardViewModel {
        
        let attributedString = NSMutableAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 34, weight: .heavy)])
        
        attributedString.append(NSAttributedString(string: "\n" + brandName, attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]))
        
        return CardViewModel(imageNames: posterPhotoNames, attributedString: attributedString, textAlignment: .center)
        
    }
    
}

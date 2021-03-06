//
//  CustomTextField.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 08/06/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit


class CustomTextField: UITextField {
    
    let padding: CGFloat
    
    init(padding: CGFloat) {
        self.padding = padding
        super.init(frame: .zero)
        layer.cornerRadius = 25
    }
    
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 50)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


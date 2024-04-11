//
//  UITextField.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/11/24.
//

import UIKit

extension UITextField {
    
    func setTextField(forBackgroundColor: UIColor, forBorderColor: UIColor? = nil, forBorderWidth: CGFloat? = nil, forCornerRadius: CGFloat? = nil) {
        self.clipsToBounds = true
        self.backgroundColor = forBackgroundColor
        
        if let forBorderColor {
            self.layer.borderColor = forBorderColor.cgColor
        }
        
        if let forBorderWidth {
            self.layer.borderWidth = forBorderWidth
        }
        
        if let cornerRadius = forCornerRadius {
            self.layer.cornerRadius = cornerRadius
        }  else {
            self.layer.cornerRadius = 0
        }
    }
    
    func setPlaceholder(placeholder: String, fontColor: UIColor?, font: UIFont) {
        self.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                        attributes: [.foregroundColor: fontColor!,
                                                                     .font: font])
    }
}

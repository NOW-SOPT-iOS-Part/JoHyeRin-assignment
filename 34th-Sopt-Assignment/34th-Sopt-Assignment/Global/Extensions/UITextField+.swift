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
    
    func setTextFont(forFont: UIFont, forFontColor: UIColor) {
        self.font = forFont
        self.textColor = forFontColor
    }
    
    func addPadding(left: CGFloat? = nil, right: CGFloat? = nil) {
        if let left {
            leftView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: 0))
            leftViewMode = .always
        }
        if let right {
            rightView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: 0))
            rightViewMode = .always
        }
    }
}

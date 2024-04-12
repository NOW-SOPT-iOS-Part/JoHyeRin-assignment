//
//  UIButton+.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/11/24.
//

import UIKit

extension UIButton {
    
    func setButton(forBackgroundColor: UIColor, forBorderColor: UIColor? = nil, forBorderWidth: CGFloat? = nil, forCornerRadius: CGFloat? = nil) {
        self.clipsToBounds = true
        self.backgroundColor = forBackgroundColor
        
        if let forBorderColor {
            layer.borderColor = forBorderColor.cgColor
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
    
    func setButtonText(forText: String, forfont: UIFont, forfontColor: UIColor? = nil) {
        self.setTitle(forText, for: .normal)
        self.titleLabel?.font = forfont
        
        if let forfontColor {
            self.titleLabel?.textColor = forfontColor
        }
    }
    
    func underlineTitle(forTitle: String) {
        guard let buttonTitle = self.titleLabel?.text else { return }
        
        let rangeToUnderLine = (buttonTitle as NSString).range(of: forTitle)
        
        let underLineTitle = NSMutableAttributedString(string: buttonTitle)
        underLineTitle.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: rangeToUnderLine)
        
        self.setAttributedTitle(underLineTitle, for: .normal)
    }
}

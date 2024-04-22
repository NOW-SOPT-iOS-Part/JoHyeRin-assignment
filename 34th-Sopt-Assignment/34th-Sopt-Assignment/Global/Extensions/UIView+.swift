//
//  UIView+.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/11/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}

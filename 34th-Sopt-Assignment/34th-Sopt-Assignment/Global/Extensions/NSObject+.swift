//
//  NSObject+.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 6/7/24.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}

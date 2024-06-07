//
//  NickNameModalViewModel.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 6/7/24.
//

import UIKit

final class NickNameModalViewModel {
    
    func isValidNickName(forNickName: String?) -> (Bool) {
        guard forNickName != nil else { return false }
        
        let nickRegEx = "[가-힣]{2,7}"
        let pred = NSPredicate(format:"SELF MATCHES %@", nickRegEx)
        return pred.evaluate(with: forNickName)
    }
}

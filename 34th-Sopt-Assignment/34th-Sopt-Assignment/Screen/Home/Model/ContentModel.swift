//
//  MovieModel.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/26/24.
//

import UIKit

struct ContentModel {
    let posterImage: UIImage
    let contentLabel: String
}

extension ContentModel {
    static let contentList: [ContentModel] = [
        ContentModel(posterImage: .singal, contentLabel: "시그널"),
        ContentModel(posterImage: .harrypotter, contentLabel: "해리포터와 마법사의 돌"),
        ContentModel(posterImage: .lordoftherings, contentLabel: "반지의 제왕"),
        ContentModel(posterImage: .suzume, contentLabel: "스즈메의 문단속")
    ]
}

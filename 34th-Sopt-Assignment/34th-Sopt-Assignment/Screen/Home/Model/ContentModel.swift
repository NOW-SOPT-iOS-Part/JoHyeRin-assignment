//
//  MovieModel.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/26/24.
//

import UIKit

struct ContentModel {
    let posterImage: UIImage
    let content: String
}

extension ContentModel {
    static let contentList: [ContentModel] = [
        ContentModel(posterImage: .singal, content: "시그널"),
        ContentModel(posterImage: .harrypotter, content: "해리포터와 마법사의 돌"),
        ContentModel(posterImage: .lordoftherings, content: "반지의 제왕"),
        ContentModel(posterImage: .suzume, content: "스즈메의 문단속")
    ]
}

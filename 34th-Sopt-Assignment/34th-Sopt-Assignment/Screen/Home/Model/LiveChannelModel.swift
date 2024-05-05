//
//  LiveChannelModel.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/26/24.
//

import UIKit

struct LiveChannelModel {
    let preViewColor: UIColor
    let rank: String
    let channel: String
    let program: String
    let percent: String
}

extension LiveChannelModel {
    static let liveChannelList: [LiveChannelModel] = [
        LiveChannelModel(preViewColor: .red, rank: "1", channel: "Mnet", program: "보이즈 플래닛 12화", percent: "80.0%"),
        LiveChannelModel(preViewColor: .green, rank: "2", channel: "Channel A", program: "하트시그널 4화", percent: "67.3%"),
        LiveChannelModel(preViewColor: .blue, rank: "3", channel: "tvN", program: "눈물의여왕 15화", percent: "51.5%")
    ]
}

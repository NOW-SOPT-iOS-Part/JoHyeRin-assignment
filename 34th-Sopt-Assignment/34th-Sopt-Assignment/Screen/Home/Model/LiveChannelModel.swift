//
//  LiveChannelModel.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/26/24.
//

import UIKit

struct LiveChannelModel {
    let preViewColor: UIColor
    let rankLabel: String
    let channelLabel: String
    let programLabel: String
    let percentLabel: String
}

extension LiveChannelModel {
    static let liveChannelList: [LiveChannelModel] = [
        LiveChannelModel(preViewColor: .red, rankLabel: "1", channelLabel: "Mnet", programLabel: "보이즈 플래닛 12화", percentLabel: "80.0%"),
        LiveChannelModel(preViewColor: .green, rankLabel: "2", channelLabel: "Channel A", programLabel: "하트시그널 4화", percentLabel: "67.3%"),
        LiveChannelModel(preViewColor: .blue, rankLabel: "3", channelLabel: "tvN", programLabel: "눈물의여왕 15화", percentLabel: "51.5%")
    ]
}

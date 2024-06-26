//
//  HomeCollectionViewLiveChannelCell.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/26/24.
//

import UIKit

import SnapKit
import Then

final class HomeCollectionViewLiveChannelCell: UICollectionViewCell {
    
    //MARK: - UI Properties
    
    private let preView = UIView()
    private let rankLabel = UILabel()
    private let channelLabel = UILabel()
    private let programLabel = UILabel()
    private let percentLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHierarchy()
        setupStyle()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeCollectionViewLiveChannelCell {
    
    // MARK: - Private Method
    
    private func setupStyle() {
        preView.do {
            $0.makeCornerRound(radius: 3)
        }
        
        rankLabel.do {
            $0.font = .pretendardFont(weight: 700, size: 19)
            $0.textColor = .white
            $0.textAlignment = .center
        }
        
        channelLabel.do {
            $0.font = .pretendardFont(weight: 400, size: 10)
            $0.textColor = .white
            $0.textAlignment = .center
        }
        
        programLabel.do {
            $0.font = .pretendardFont(weight: 400, size: 10)
            $0.textColor = .tvingGray2
            $0.textAlignment = .center
        }
        
        percentLabel.do {
            $0.font = .pretendardFont(weight: 400, size: 10)
            $0.textColor = .tvingGray2
            $0.textAlignment = .center
        }
    }
    
    private func setupHierarchy() {
        self.addSubviews(
            preView,
            rankLabel,
            channelLabel,
            programLabel,
            percentLabel
        )
    }
    
    private func setupLayout() {
        preView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(80)
            $0.width.equalTo(160)
        }
        
        rankLabel.snp.makeConstraints {
            $0.top.equalTo(preView.snp.bottom).offset(11)
            $0.leading.equalToSuperview().inset(8)
        }
        
        channelLabel.snp.makeConstraints {
            $0.top.equalTo(preView.snp.bottom).offset(11)
            $0.leading.equalTo(rankLabel.snp.trailing).offset(8)
        }
        
        programLabel.snp.makeConstraints {
            $0.top.equalTo(channelLabel.snp.bottom).offset(4)
            $0.leading.equalTo(channelLabel.snp.leading)
        }
        
        percentLabel.snp.makeConstraints {
            $0.top.equalTo(programLabel.snp.bottom).offset(4)
            $0.leading.equalTo(channelLabel.snp.leading)
        }
    }
    
    //MARK: - Method
    
    func configureCell(forLiveChannel: LiveChannelModel) {
        preView.backgroundColor = forLiveChannel.preViewColor
        rankLabel.text = forLiveChannel.rank
        channelLabel.text = forLiveChannel.channel
        programLabel.text = forLiveChannel.program
        percentLabel.text = forLiveChannel.percent
    }
}

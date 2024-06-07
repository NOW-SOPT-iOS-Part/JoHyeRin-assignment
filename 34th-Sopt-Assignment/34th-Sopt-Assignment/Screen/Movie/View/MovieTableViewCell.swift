//
//  MovieTableViewCell.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 5/7/24.
//

import UIKit

import SnapKit
import Then

final class MovieTableViewCell: UITableViewCell {
    
    //MARK: - UI Properties
    
    private let rankLabel = UILabel()
    private let movieNameLabel = UILabel()
    private let openDateLabel = UILabel()
    private let audienceLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupHierarchy()
        setupStyle()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieTableViewCell {
    
    // MARK: - Private Method
    
    private func setupStyle() {
        self.backgroundColor = .black
        
        rankLabel.do {
            $0.font = .pretendardFont(weight: 700, size: 40)
            $0.textColor = .white
            $0.textAlignment = .center
        }
        
        movieNameLabel.do {
            $0.font = .pretendardFont(weight: 700, size: 20)
            $0.textColor = .white
            $0.textAlignment = .center
        }
        
        openDateLabel.do {
            $0.font = .pretendardFont(weight: 500, size: 17)
            $0.textColor = .white
            $0.textAlignment = .center
        }
        
        audienceLabel.do {
            $0.font = .pretendardFont(weight: 600, size: 17)
            $0.textColor = .white
            $0.textAlignment = .center
        }
    }
    
    private func setupHierarchy() {
        self.addSubviews(
            rankLabel,
            movieNameLabel,
            openDateLabel,
            audienceLabel
        )
    }
    
    private func setupLayout() {
        rankLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        movieNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalTo(rankLabel.snp.trailing).offset(20)
        }
        
        openDateLabel.snp.makeConstraints {
            $0.top.equalTo(movieNameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(movieNameLabel.snp.leading)
        }
        
        audienceLabel.snp.makeConstraints {
            $0.top.equalTo(openDateLabel.snp.bottom).offset(5)
            $0.leading.equalTo(movieNameLabel.snp.leading)
        }
    }
    
    //MARK: - Method
    
    func configureCell(_ movieData: DailyBoxOfficeList) {
        guard let audienceCount = Int(movieData.audiAcc) else { return }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        
        let newAudienceCount = formatter.string(from: NSNumber(value: audienceCount))
        
        rankLabel.text = movieData.rank
        movieNameLabel.text = movieData.movieNm
        openDateLabel.text = "\(movieData.openDt) 개봉"
        if let newAudienceCount {
            audienceLabel.text = "누적 관객 수: \(newAudienceCount)명"
        }
    }
}

//
//  HomeCollectionViewCell.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/26/24.
//

import UIKit

import SnapKit
import Then

final class HomeCollectionViewContentCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let identifier = "homeCollectionViewPosterCell"
    
    //MARK: - UI Properties
    
    private let posterImage = UIImageView()
    private let contentLabel = UILabel()
    
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

extension HomeCollectionViewContentCell {
    
    // MARK: - Private Method
    
    private func setupStyle() {
        posterImage.do {
            $0.makeCornerRound(radius: 3)
        }
        
        contentLabel.do {
            $0.font = .pretendardFont(weight: 500, size: 10)
            $0.textColor = .tvingGray2
            $0.textAlignment = .center
        }
    }
    
    private func setupHierarchy() {
        self.addSubviews(
            posterImage,
            contentLabel
        )
    }
    
    private func setupLayout() {
        posterImage.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(146)
            $0.width.equalTo(98)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(posterImage.snp.bottom).offset(3)
            $0.leading.equalToSuperview()
        }
    }
    
    //MARK: - Method
    
    func configureCell(forContent: ContentModel) {
        posterImage.image = forContent.posterImage
        contentLabel.text = forContent.content
    }
}

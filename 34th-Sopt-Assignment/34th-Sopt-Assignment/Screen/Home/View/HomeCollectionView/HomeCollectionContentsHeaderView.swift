//
//  HomeCollectionHeaderView.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/26/24.
//

import UIKit

import SnapKit

final class HomeCollectionContentsHeaderView: UICollectionReusableView {
    
    // MARK: - UI Properties
    
    private let titleLabel = UILabel()
    private let viewAllLabel = UILabel()
    
    
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

extension HomeCollectionContentsHeaderView {
    
    // MARK: - Private Method
    
    private func setupStyle() {
        titleLabel.do {
            $0.font = .pretendardFont(weight: 600, size: 15)
            $0.textColor = .white
            $0.textAlignment = .center
        }
        
        viewAllLabel.do {
            $0.text = "전체보기 >"
            $0.font = .pretendardFont(weight: 500, size: 11)
            $0.textColor = .tvingGray2
            $0.textAlignment = .center
        }
    }
    
    private func setupHierarchy() {
        self.addSubviews(
            titleLabel,
            viewAllLabel
        )
    }

    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
        }
        
        viewAllLabel.snp.makeConstraints {
            $0.trailing.centerY.equalToSuperview()
        }
    }
    
    //MARK: - Method
    
    func configureHeader(fortitle: String) {
        titleLabel.text = fortitle
    }
}

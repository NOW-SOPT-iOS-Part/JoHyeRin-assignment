//
//  TabbarCollectionViewCell.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/25/24.
//

import UIKit
import Then

final class TopTabbarCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let identifier = "topTabbarCollectionViewCell"
    
    //MARK: - UI Properties
    
    private let tabLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStyle()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TopTabbarCollectionViewCell {
    
    // MARK: - Privat Method
    
    private func setupStyle() {
        tabLabel.do {
            $0.text = ""
            $0.font = .pretendardFont(weight: 400, size: 17)
            $0.textColor = .white
            $0.textAlignment = .center
        }
    }
    
    private func setupLayout() {
        self.addSubviews(
            tabLabel
        )
        
        tabLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    //MARK: - Method
    
    func configureCell(forTab: String) {
        tabLabel.text = forTab
    }
}

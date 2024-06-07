//
//  HomeCollectionViewAdCell.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/30/24.
//

import UIKit

import SnapKit
import Then

final class HomeCollectionViewAdCell: UICollectionViewCell {
    
    //MARK: - UI Properties
    
    private let posterImage = UIImageView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeCollectionViewAdCell {
    
    // MARK: - Private Method
    
    private func setupHierarchy() {
        self.addSubviews(
            posterImage
        )
    }
    
    private func setupLayout() {
        posterImage.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(58)
        }
    }
    
    //MARK: - Method
    
    func configureCell(forAd: UIImage) {
        posterImage.image = forAd
    }
}

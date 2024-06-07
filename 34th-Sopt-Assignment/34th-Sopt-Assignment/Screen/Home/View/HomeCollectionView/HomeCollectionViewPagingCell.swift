//
//  HomeCollectionViewPagingCell.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/26/24.
//

import UIKit

import SnapKit
import Then

final class HomeCollectionViewPagingCell: UICollectionViewCell {
    
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

extension HomeCollectionViewPagingCell {
    
    // MARK: - Private Method
    
    private func setupHierarchy() {
        self.addSubviews(
            posterImage
        )
    }
    
    private func setupLayout() {
        posterImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    //MARK: - Method
    
    func configureCell(forPage: UIImage) {
        posterImage.image = forPage
    }
}

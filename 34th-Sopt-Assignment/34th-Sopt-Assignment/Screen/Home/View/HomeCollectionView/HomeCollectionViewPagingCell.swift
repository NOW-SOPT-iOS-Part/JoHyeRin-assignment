//
//  HomeCollectionViewPagingCell.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/26/24.
//

import UIKit
import Then

final class HomeCollectionViewPagingCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let identifier = "homeCollectionViewPagingCell"
    
    //MARK: - UI Properties
    
    private let posterImage = UIImageView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeCollectionViewPagingCell {
    
    // MARK: - Privat Method
    
    private func setupLayout() {
        self.addSubviews(
            posterImage
        )
        
        posterImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    //MARK: - Method
    
    func configureCell(forPage: UIImage) {
        posterImage.image = forPage
    }
}

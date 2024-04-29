//
//  HomeCollectionFooterView.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/30/24.
//

import UIKit
import SnapKit

final class HomeCollectionPagingFooterView: UICollectionReusableView {
    
    // MARK: - Properties
    
    static let identifier = "homeCollectionPagingFooterView"
    
    // MARK: - UI Properties
    
    private let pageControll = UIPageControl()
    
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

extension HomeCollectionPagingFooterView {
    
    // MARK: - Privat Method
    
    private func setupStyle() {
        pageControll.do {
            $0.numberOfPages = 8
            $0.currentPageIndicatorTintColor = .tvingGray1
            $0.pageIndicatorTintColor = .tvingGray3
            $0.currentPage = 0
            $0.preferredIndicatorImage = UIImage(resource: .pageIndicator)
        }
    }

    private func setupLayout() {
        self.addSubviews(
            pageControll
        )
        
        pageControll.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(-15)
        }
    }
    
    //MARK: - Method
    
    func setupPageIndex(forIndex: Int) {
        pageControll.currentPage = forIndex
    }
}

//
//  HomeView.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/26/24.
//

import UIKit

import SnapKit
import Then

final class HomeView: UIView {
    
    //MARK: - UI Properties
    
    private let homeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

    
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

extension HomeView {
    
    // MARK: - Private Method
    
    private func setupStyle() {
        self.backgroundColor = .black
        
        homeCollectionView.do {
            $0.collectionViewLayout = CompositionalFactory.create()
            $0.backgroundColor = .clear
            $0.register(HomeCollectionViewPagingCell.self, forCellWithReuseIdentifier: HomeCollectionViewPagingCell.className)
            $0.register(HomeCollectionViewContentCell.self, forCellWithReuseIdentifier: HomeCollectionViewContentCell.className)
            $0.register(HomeCollectionViewLiveChannelCell.self, forCellWithReuseIdentifier: HomeCollectionViewLiveChannelCell.className)
            $0.register(HomeCollectionViewAdCell.self, forCellWithReuseIdentifier: HomeCollectionViewAdCell.className)
            $0.register(HomeCollectionContentsHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier:HomeCollectionContentsHeaderView.className)
            $0.register(HomeCollectionPagingFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HomeCollectionPagingFooterView.className)
        }
    }
    
    private func setupHierarchy() {
        self.addSubview(homeCollectionView)
    }
    
    private func setupLayout() {
        homeCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    //MARK: - Method
    
    func setupCollectionView(_ viewController: UIViewController) {
        homeCollectionView.delegate = viewController as? UICollectionViewDelegate
        homeCollectionView.dataSource = viewController as? UICollectionViewDataSource
    }
}


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
            $0.collectionViewLayout = createCollectionViewLayout()
            $0.backgroundColor = .clear
            $0.register(HomeCollectionViewPagingCell.self, forCellWithReuseIdentifier: HomeCollectionViewPagingCell.identifier)
            $0.register(HomeCollectionViewContentCell.self, forCellWithReuseIdentifier: HomeCollectionViewContentCell.identifier)
            $0.register(HomeCollectionViewLiveChannelCell.self, forCellWithReuseIdentifier: HomeCollectionViewLiveChannelCell.identifier)
            $0.register(HomeCollectionViewAdCell.self, forCellWithReuseIdentifier: HomeCollectionViewAdCell.identifier)
            $0.register(HomeCollectionContentsHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier:HomeCollectionContentsHeaderView.identifier)
            $0.register(HomeCollectionPagingFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HomeCollectionPagingFooterView.identifier)
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
    
    private func createPagingLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(498))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
        let footerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottomLeading)
        section.boundarySupplementaryItems = [footerElement]
        
        return section
    }
    
    private func createContentLayout() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(98), heightDimension: .absolute(170))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(98), heightDimension: .absolute(170))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
        section.orthogonalScrollingBehavior = .continuous
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        section.boundarySupplementaryItems = [headerElement]

        return section
    }
    
    private func createLiveChannelLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(160), heightDimension: .absolute(140))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(160), heightDimension: .absolute(140))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 7
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
        section.orthogonalScrollingBehavior = .continuous
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        section.boundarySupplementaryItems = [headerElement]
        
        return section
    }
    
    private func createAdLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    private func createDefaultLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionNumber, env -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0:
                return self?.createPagingLayout()
            case 1, 3, 5:
                return self?.createContentLayout()
            case 2:
                return self?.createLiveChannelLayout()
            case 4:
                return self?.createAdLayout()
            default:
                return self?.createDefaultLayout()
            }
        }
        return layout
    }
    
    //MARK: - Method
    
    func setupCollectionView(_ viewController: UIViewController) {
        homeCollectionView.delegate = viewController as? UICollectionViewDelegate
        homeCollectionView.dataSource = viewController as? UICollectionViewDataSource
    }
}


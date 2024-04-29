//
//  HomeViewContoller.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/26/24.
//

import UIKit

final class HomeViewController: UIViewController {
    
    //MARK: - Properties
    
    private let rootView = HomeView()
    private let pageList: [UIImage] = [.yourname, .yourname1, .yourname2, .yourname3, .yourname, .yourname1, .yourname2, .yourname3]
    private let contentModelList = ContentModel.contentList
    private let liveChannelModelList = LiveChannelModel.liveChannelList
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        setDelegate()
    }
}

extension HomeViewController {
    
    // MARK: - Privat Method
    
    private func setDelegate() {
        rootView.setupCollectionView(self)
    }
}

//MARK: - CollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return pageList.count
        case 1:
            return contentModelList.count
        case 2:
            return liveChannelModelList.count
        case 3:
            return contentModelList.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewPagingCell.identifier, for: indexPath) as? HomeCollectionViewPagingCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(forPage: pageList[indexPath.item])
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewContentCell.identifier, for: indexPath) as? HomeCollectionViewContentCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(forContent: contentModelList[indexPath.item])
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewLiveChannelCell.identifier, for: indexPath) as? HomeCollectionViewLiveChannelCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(forLiveChannel: liveChannelModelList[indexPath.item])
            return cell
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewContentCell.identifier, for: indexPath) as? HomeCollectionViewContentCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(forContent: contentModelList[indexPath.item])
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 1:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeCollectionContentsHeaderView.identifier, for: indexPath) as? HomeCollectionContentsHeaderView else {
                return UICollectionReusableView()
            }
            headerView.configureHeader(fortitle: "티빙에서 꼭 봐야하는 콘텐츠")
            
            return headerView
        case 2:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeCollectionContentsHeaderView.identifier, for: indexPath) as? HomeCollectionContentsHeaderView else {
                return UICollectionReusableView()
            }
            headerView.configureHeader(fortitle: "인기 LIVE 채널")
            
            return headerView
        case 3:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeCollectionContentsHeaderView.identifier, for: indexPath) as? HomeCollectionContentsHeaderView else {
                return UICollectionReusableView()
            }
            headerView.configureHeader(fortitle: "1화 무료! 파라마운트+ 인기 시리즈")
            
            return headerView
        default: return UICollectionReusableView()
        }
    }
}

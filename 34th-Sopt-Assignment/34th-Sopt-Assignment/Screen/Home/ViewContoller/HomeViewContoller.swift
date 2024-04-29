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
    private let contentPageList: [UIImage] = [.yourname, .yourname1, .yourname2, .yourname3, .yourname, .yourname1, .yourname2, .yourname3]
    private let contentModelList = ContentModel.contentList
    private let liveChannelModelList = LiveChannelModel.liveChannelList
    private let adPageList: [UIImage] = [.baseball, .baseball1]
    
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
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return contentPageList.count
        case 1:
            return contentModelList.count
        case 2:
            return liveChannelModelList.count
        case 3:
            return contentModelList.count
        case 4:
            return adPageList.count
        case 5:
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
            cell.configureCell(forPage: contentPageList[indexPath.item])
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
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewAdCell.identifier, for: indexPath) as? HomeCollectionViewAdCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(forAd: adPageList[indexPath.item])
            return cell
        case 5:
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
        case 0:
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeCollectionPagingFooterView.identifier, for: indexPath) as? HomeCollectionPagingFooterView else {
                return UICollectionReusableView()
            }
            return footerView
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
        case 5:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeCollectionContentsHeaderView.identifier, for: indexPath) as? HomeCollectionContentsHeaderView else {
                return UICollectionReusableView()
            }
            headerView.configureHeader(fortitle: "마술보다 더 신비로운 영화(신비로운 영화사전님)")
            
            return headerView
        default: return UICollectionReusableView()
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if let footers = collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionFooter) as? [HomeCollectionPagingFooterView], let footer = footers.first {
                
                let currentPageIndex = indexPath.row
                footer.setupPageIndex(forIndex: currentPageIndex)
            }
        }
    }
}

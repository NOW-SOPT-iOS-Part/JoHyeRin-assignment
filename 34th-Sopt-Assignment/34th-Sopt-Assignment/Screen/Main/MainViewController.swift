//
//  MainViewController.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/24/24.
//

import UIKit

final class MainViewController: UIViewController {
    
    //MARK: - Properties
    
    private let rootView = MainView()
    private let tabData = ["홈", "실시간", "TV프로그램", "영화", "파라마운트+"]
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        setAddTarget()
        setDelegate()
    }
}

extension MainViewController {
    
    // MARK: - Privat Method
    
    private func setAddTarget() {
        
    }
    
    private func setDelegate() {
        rootView.setupCollectionView(self)
    }
    
    //MARK: - Objc Method
}

//MARK: - CollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabbarCollectionViewCell.identifier, for: indexPath) as? TabbarCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(forTab: tabData[indexPath.item])
        rootView.fetchDividerWidth(forWidth: collectionView.contentSize.width)
        
        return cell
    }
}

//MARK: - CollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tabName = tabData[indexPath.item]
        let cellSize = tabName.size(withAttributes: [NSAttributedString.Key.font: UIFont.pretendardFont(weight: 400, size: 17)])
        return CGSize(width: cellSize.width, height: 37)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedCell = collectionView.dequeueReusableCell(withReuseIdentifier: TabbarCollectionViewCell.identifier, for: indexPath) as? TabbarCollectionViewCell {
            rootView.moveIndicatorView(forCell: selectedCell)
        }
    }
}

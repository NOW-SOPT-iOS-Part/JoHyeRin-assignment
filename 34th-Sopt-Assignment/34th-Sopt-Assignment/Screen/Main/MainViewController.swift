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
        
        setDelegate()
        rootView.setupPageViewController(self)
    }
}

extension MainViewController {
    
    // MARK: - Private Method
    
    private func setDelegate() {
        rootView.setupCollectionView(self)
        rootView.setupPageViewController(self)
        rootView.setupStickyDelegate(self)
    }
}

//MARK: - CollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopTabbarCollectionViewCell.identifier, for: indexPath) as? TopTabbarCollectionViewCell else {
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
        if let selectedCell = collectionView.dequeueReusableCell(withReuseIdentifier: TopTabbarCollectionViewCell.identifier, for: indexPath) as? TopTabbarCollectionViewCell {
            rootView.moveIndicatorView(forCell: selectedCell)
        }
        rootView.fetchPageViewforIndexPath(indexPath: indexPath)
    }
}

//MARK: - PageViewControllerDataSource/Delegate

extension MainViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = rootView.tabViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        
        return rootView.tabViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = rootView.tabViewControllers.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = index + 1
        if nextIndex == rootView.tabViewControllers.count {
            return nil
        }
        return rootView.tabViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished && completed {
            if let currentViewController = pageViewController.viewControllers?.first {
                if let currentIndex = rootView.tabViewControllers.firstIndex(of: currentViewController) {
                    rootView.fetchCellforIndex(index: currentIndex)
                }
            }
        }
    }
}

//MARK: - StickyDelegate

extension MainViewController: stickyDelegate {
    func updateCollectionViewFrame(offsetY: CGFloat?) {
        if let offsetY {
            rootView.logoView.frame.origin.y = -offsetY
            if offsetY > 2 {
                rootView.topTabbarView.frame.origin.y = 59
                rootView.blackView.frame.origin.y = -61
            } else {
                rootView.topTabbarView.frame.origin.y = -offsetY + 61
                rootView.blackView.frame.origin.y = -offsetY - 60
            }
            
            let startOffset = CGFloat(-59)
            let finishOffset = CGFloat(0)
            
            if offsetY <= finishOffset && offsetY >= startOffset {
                let alphaRange = CGFloat(1) - CGFloat(0)
                let offsetRange = finishOffset - startOffset
                
                let offsetFraction = (offsetY - startOffset) / offsetRange //현재 offset에 대한 alpha 비율
                let alpha = CGFloat(0) + (alphaRange * offsetFraction) //alpha 구하기
                
                rootView.blackView.alpha = alpha
            } else if offsetY < startOffset {
                rootView.blackView.alpha = 0
            } else if offsetY > finishOffset {
                rootView.blackView.alpha = 1
            }
        }
    }
}

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
    
    // MARK: - Privat Method
    
    private func setDelegate() {
        rootView.setupCollectionView(self)
        rootView.setupPageViewController(self)
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

extension MainViewController: UICollectionViewDelegate {
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
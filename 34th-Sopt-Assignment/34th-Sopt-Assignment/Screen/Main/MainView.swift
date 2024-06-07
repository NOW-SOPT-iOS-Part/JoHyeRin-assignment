//
//  MainView.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/24/24.
//

import UIKit

import SnapKit
import Then

final class MainView: UIView {
    
    //MARK: - Properties
    
    private var presentCellIndexPath: IndexPath = [0, 0]
    private let tabName = ["홈", "실시간", "TV프로그램", "영화", "파라마운트+"]
    
    private let homeVC = HomeViewController()
    private lazy var liveVC = LiveViewController()
    private lazy var tvVC = TvProgramViewController()
    private lazy var movieVC = MovieViewController()
    private lazy var pmVC = ParamountViewController()
    lazy var tabViewControllers = [homeVC, liveVC, tvVC, movieVC, pmVC]
    
    //MARK: - UI Properties
    
    let logoView = UIView()
    private let logoImageView = UIImageView(image: .tvingLabelLogo)
    private let profileImageView = UIImageView(image: .profile)
    let topTabbarView = UIView()
    let blackView = UIView()
    private let topTabbarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let dividerView = UIView()
    let indicatorView = UIView()
    lazy var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHierarchy()
        setupStyle()
        setupLayout()
        
        if let firstVC = tabViewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainView {
    
    // MARK: - Private Method
    
    private func setupStyle() {
        self.backgroundColor = .black
        
        topTabbarCollectionView.do {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            
            $0.collectionViewLayout = flowLayout
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
            $0.register(TopTabbarCollectionViewCell.self, forCellWithReuseIdentifier: TopTabbarCollectionViewCell.className)
        }
        
        logoView.do {
            $0.backgroundColor = .clear
        }
        
        topTabbarView.do {
            $0.backgroundColor = .clear
        }
        
        blackView.do {
            $0.backgroundColor = .black
        }
        
        dividerView.do {
            $0.backgroundColor = .tvingGray4
        }
        
        indicatorView.do {
            $0.backgroundColor = .white
        }
    }
    
    private func setupHierarchy() {
        self.addSubviews(
            pageViewController.view,
            blackView,
            logoView,
            topTabbarView
        )
        
        logoView.addSubviews(
            logoImageView,
            profileImageView
        )
        
        blackView.addSubview(dividerView)
        
        topTabbarView.addSubviews(
            topTabbarCollectionView,
            indicatorView
        )
    }
    
    private func setupLayout() {
        pageViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualToSuperview().priority(.low)
        }
        
        logoView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalTo(dividerView.snp.top)
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.leading.equalToSuperview().inset(11)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(17)
            $0.trailing.equalToSuperview().inset(9)
        }
        
        blackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(dividerView.snp.top)
        }
        
        topTabbarView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        topTabbarCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(37)
            $0.horizontalEdges.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(topTabbarCollectionView.snp.bottom).offset(1)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        indicatorView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.centerY.equalTo(dividerView.snp.centerY)
            $0.height.equalTo(3)
            $0.width.equalTo(15)
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Method
    
    func setupPageViewController(_ viewController: UIViewController) {
        viewController.addChild(pageViewController)
        pageViewController.dataSource = viewController as? UIPageViewControllerDataSource
        pageViewController.delegate = viewController as? UIPageViewControllerDelegate
    }
    
    func setupCollectionView(_ viewController: UIViewController) {
        topTabbarCollectionView.delegate = viewController as? UICollectionViewDelegate
        topTabbarCollectionView.dataSource = viewController as? UICollectionViewDataSource
    }
    
    func setupStickyDelegate(_ viewController: UIViewController) {
        homeVC.delegate = viewController as? any stickyDelegate
    }
    
    func moveIndicatorView(forCell: UICollectionViewCell) {
        indicatorView.snp.remakeConstraints {
            $0.leading.equalTo(forCell.frame.origin.x)
            $0.width.equalTo(forCell.frame.size.width)
            $0.height.equalTo(3)
            $0.centerY.equalTo(dividerView.snp.centerY)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    func fetchDividerWidth(forWidth: CGFloat) {
        dividerView.snp.remakeConstraints {
            $0.top.equalTo(topTabbarCollectionView.snp.bottom).offset(1)
            $0.height.equalTo(1)
            $0.width.equalTo(forWidth)
        }
    }
    
    func fetchPageViewforIndexPath(indexPath: IndexPath) {
        let vc = tabViewControllers[indexPath.item]
        
        if presentCellIndexPath.item < indexPath.item {
            pageViewController.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
        } else {
            pageViewController.setViewControllers([vc], direction: .reverse, animated: true, completion: nil)
        }
        presentCellIndexPath = indexPath
    }
    
    func fetchCellforIndex(index: Int) {
        if let tabCell = topTabbarCollectionView.dequeueReusableCell(withReuseIdentifier: TopTabbarCollectionViewCell.className, for: [0, index]) as? TopTabbarCollectionViewCell {
            moveIndicatorView(forCell: tabCell)
            presentCellIndexPath = [0, index]
        }
    }
}

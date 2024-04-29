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
    
    private lazy var homeVC = HomeViewController()
    private lazy var liveVC = LiveViewController()
    private lazy var tvVC = TvProgramViewController()
    private lazy var movieVC = MovieViewController()
    private lazy var pmVC = ParamountViewController()
    lazy var tabViewControllers = [homeVC, liveVC, tvVC, movieVC, pmVC]
    
    //MARK: - UI Properties
    
    private let logoImageView = UIImageView(image: .tvingLabelLogo)
    private let profileImageView = UIImageView(image: .profile)
    let topTabbarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let dividerView = UIView()
    private let indicatorView = UIView()
    lazy var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStyle()
        setupLayout()
        
        if let firstVC = tabViewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset" {
            if let newOffset = change?[.newKey] as? CGPoint {
                // 콜렉션뷰의 스크롤 오프셋을 이용하여 UIView의 프레임을 업데이트
                dividerView.frame.origin.x = -(newOffset.x)
            }
        }
    }
}

extension MainView {
    
    // MARK: - Privat Method
    
    private func setupStyle() {
        self.backgroundColor = .black
        
        topTabbarCollectionView.do {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            
            $0.collectionViewLayout = flowLayout
            $0.backgroundColor = .clear
            $0.register(TopTabbarCollectionViewCell.self, forCellWithReuseIdentifier: TopTabbarCollectionViewCell.identifier)
            $0.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        }
        
        dividerView.do {
            $0.backgroundColor = .tvingGray4
        }
        
        indicatorView.do {
            $0.backgroundColor = .white
        }
    }
    
    
    private func setupLayout() {
        self.addSubviews(
            pageViewController.view,
            logoImageView,
            profileImageView,
            topTabbarCollectionView,
            dividerView
        )
        
        dividerView.addSubview(indicatorView)
        
        pageViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualToSuperview().priority(.low)
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(53)
            $0.leading.equalToSuperview().inset(11)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(50)
            $0.trailing.equalToSuperview().inset(9)
        }
        
        topTabbarCollectionView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(15)
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
        if let tabCell = topTabbarCollectionView.dequeueReusableCell(withReuseIdentifier: TopTabbarCollectionViewCell.identifier, for: [0, index]) as? TopTabbarCollectionViewCell {
            moveIndicatorView(forCell: tabCell)
            presentCellIndexPath = [0, index]
        }
    }
}

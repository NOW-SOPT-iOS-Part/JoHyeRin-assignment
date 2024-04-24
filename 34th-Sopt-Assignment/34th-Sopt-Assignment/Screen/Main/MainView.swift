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
    
    //MARK: - UI Properties
    
    private let logoImageView = UIImageView(image: .tvingLabelLogo)
    private let profileImageView = UIImageView(image: .profile)
    private let topTabbarView = UIView()
    private let tabbarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let dividerView = UIView()
    private let indicatorView = UIView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStyle()
        setupLayout()
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
        
        tabbarCollectionView.do {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            
            $0.collectionViewLayout = flowLayout
            $0.backgroundColor = .clear
            $0.register(TabbarCollectionViewCell.self, forCellWithReuseIdentifier: TabbarCollectionViewCell.identifier)
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
            logoImageView,
            profileImageView,
            tabbarCollectionView,
            dividerView
        )
        
        dividerView.addSubview(indicatorView)
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(58)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(11)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(55)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(9)
        }
        
        tabbarCollectionView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(15)
            $0.height.equalTo(37)
            $0.horizontalEdges.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(tabbarCollectionView.snp.bottom).offset(1)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        indicatorView.snp.makeConstraints {
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(18)
            $0.centerY.equalTo(dividerView.snp.centerY)
            $0.height.equalTo(3)
            $0.width.equalTo(15)
        }
    }
    
    //MARK: - Method
    
    func setupCollectionView(_ viewController: UIViewController) {
        tabbarCollectionView.delegate = viewController as? UICollectionViewDelegate
        tabbarCollectionView.dataSource = viewController as? UICollectionViewDataSource
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
            $0.top.equalTo(tabbarCollectionView.snp.bottom).offset(1)
            $0.height.equalTo(1)
            $0.width.equalTo(forWidth)
        }
    }
}


//
//  MovieView.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 5/7/24.
//

import UIKit

import SnapKit
import Then

final class MovieView: UIView {
    
    //MARK: - UI Properties
    
    private let movieTableView = UITableView()
    
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

extension MovieView {
   
    // MARK: - Private Method
    
    private func setupStyle() {
        self.backgroundColor = .black
        
        movieTableView.do {
            $0.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.className)
            $0.backgroundColor = .black
        }
    }
    
    private func setupHierarchy() {
        self.addSubview(movieTableView)
    }
    
    private func setupLayout() {
        movieTableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(160)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Method
    
    func setupTableView(_ viewController: UIViewController) {
        movieTableView.delegate = viewController as? UITableViewDelegate
        movieTableView.dataSource = viewController as? UITableViewDataSource
    }
    
    func updateTableView() {
        movieTableView.reloadData()
    }
}

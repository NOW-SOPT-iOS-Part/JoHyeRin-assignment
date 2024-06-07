//
//  MovieViewController_MVVM.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 6/7/24.
//

import UIKit

import SnapKit

final class MovieViewController_MVVM: UIViewController {
    
    //MARK: - Properties

    private let rootView = MovieView()
    private let viewModel = MovieViewModel()
    
    // MARK: - Life Cycle

    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setDelegate()
        setupAPI()
        bindViewModel()
    }
}

extension MovieViewController_MVVM {
    
    // MARK: - Private Method
    
    private func setDelegate() {
        rootView.setupTableView(self)
    }
    
    private func setupAPI() {
        viewModel.getDailyBoxOfficeModelList()
    }
    
    private func bindViewModel() {
        viewModel.setupChangeDailyBoxOfficeModelAction {
            self.updateUI()
        }
    }
    
    private func updateUI() {
        DispatchQueue.main.async { [weak self] in
            self?.rootView.updateTableView()
        }
    }
}

//MARK: - TableViewDelegate

extension MovieViewController_MVVM: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

//MARK: - TableViewDataSource

extension MovieViewController_MVVM: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = viewModel.dailyBoxOfficeModelList else { return 0 }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.className, for: indexPath) as?
                MovieTableViewCell else { return UITableViewCell() }
        
        if let data = viewModel.dailyBoxOfficeModelList {
            cell.configureCell(data[indexPath.row])
        }
        return cell
    }
}

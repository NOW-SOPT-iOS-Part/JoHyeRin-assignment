//
//  MovieViewController.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 5/7/24.
//

import UIKit

import SnapKit

final class MovieViewController: UIViewController {
    
    //MARK: - Properties

    private let rootView = MovieView()
    
    private var dailyBoxOfficeModelList: [DailyBoxOfficeList]? {
        didSet {
            self.updateUI()
        }
    }
    
    // MARK: - Life Cycle

    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setDelegate()
        getDailyBoxOfficeModelList()
    }
    
    private func getDailyBoxOfficeModelList() {
        var date = ""
        
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        if let yesterday {
            date = format.string(from: yesterday)
        }
        
        BoxOfficeService.shared.getDailyBoxOffice(date: date) { [weak self] response in
            switch response {
            case .success(let data):
                guard let data = data as? MovieModel else {
                    return }
                self?.dailyBoxOfficeModelList = data.boxOfficeResult.dailyBoxOfficeList
            case .requestErr:
                print("요청 오류 입니다")
            case .decodedErr:
                print("디코딩 오류 입니다")
            case .pathErr:
                print("경로 오류 입니다")
            case .serverErr:
                print("서버 오류입니다")
            case .networkFail:
                print("네트워크 오류입니다")
            }
        }
    }
}

extension MovieViewController {
    
    // MARK: - Private Method
    
    private func setDelegate() {
        rootView.setupTableView(self)
    }
    
    private func updateUI() {
        DispatchQueue.main.async { [weak self] in
            self?.rootView.updateTableView()
        }
    }
}

extension MovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dailyBoxOfficeModelList else { return 0 }
        return dailyBoxOfficeModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as?
                MovieTableViewCell else { return UITableViewCell() }
        
        if let dailyBoxOfficeModelList {
            cell.configureCell(dailyBoxOfficeModelList[indexPath.row])
        }
        return cell
    }
}

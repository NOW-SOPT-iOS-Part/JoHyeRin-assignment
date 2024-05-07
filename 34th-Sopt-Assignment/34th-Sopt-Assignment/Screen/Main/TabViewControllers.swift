//
//  TabViewControllers.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/26/24.
//

import UIKit

final class LiveViewController: UIViewController {
    let image = UIImageView(image: .live)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(image)
        
        image.snp.makeConstraints {
            $0.top.equalToSuperview().inset(150)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(600)
        }
    }
}

final class TvProgramViewController: UIViewController {
    let image = UIImageView(image: .tv)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(image)
        
        image.snp.makeConstraints {
            $0.top.equalToSuperview().inset(150)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(600)
        }
    }
}

final class ParamountViewController: UIViewController {
    let image = UIImageView(image: .paramount)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(image)
        
        image.snp.makeConstraints {
            $0.top.equalToSuperview().inset(150)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(600)
        }
    }
}

//
//  welcomeViewController.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/14/24.
//

import UIKit
import SnapKit

final class WelcomeViewController: UIViewController {
    var id: String?
    
    private let logoImage = UIImageView(image: UIImage(named: "tvingLogo"))
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .tvingGray1
        label.font = .pretendardFont(weight: 700, size: 23)
        label.numberOfLines = 2
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var goToMainButton: UIButton = {
        let button = UIButton()
        button.setButton(forBackgroundColor: .tvingRed, forCornerRadius: 3)
        button.setButtonText(forText: "메인으로", forfont: .pretendardFont(weight: 600, size: 14), forfontColor: .white)
        button.addTarget(self, action: #selector(gotoMainButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        navigationController?.isNavigationBarHidden = true
        
        setupLayout()
        bindID()
    }
}

extension WelcomeViewController {
    private func setupLayout() {
        self.view.addSubviews(
            logoImage,
            welcomeLabel,
            goToMainButton
        )
        
        logoImage.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(67)
            $0.centerX.equalToSuperview()
        }
        
        goToMainButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(50)
        }
    }
    
    private func bindID() {
        if let id {
            welcomeLabel.text = "\(id)님\n반가워요!!"
        }
    }
    
    @objc func gotoMainButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

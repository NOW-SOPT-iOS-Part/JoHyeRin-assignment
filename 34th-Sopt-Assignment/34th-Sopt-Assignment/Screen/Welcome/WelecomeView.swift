//
//  WelecomeView.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/24/24.
//

import UIKit
import SnapKit
import Then

final class WelecomeView: UIView {
    
    //MARK: - UI Properties
    
    private let logoImage = UIImageView(image: UIImage(named: "tvingLogo"))
    private let welcomeLabel = UILabel()
    let goToMainButton = UIButton()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStyle()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WelecomeView {
   
    // MARK: - Privat Method
    
    private func setupStyle() {
        self.backgroundColor = .black
        
        welcomeLabel.do {
            $0.textColor = .tvingGray1
            $0.font = .pretendardFont(weight: 700, size: 23)
            $0.numberOfLines = 2
            $0.textAlignment = .center
        }
        
        goToMainButton.do {
            $0.setButton(forBackgroundColor: .tvingRed, forCornerRadius: 3)
            $0.setButtonText(forText: "메인으로", forfont: .pretendardFont(weight: 600, size: 14), forfontColor: .white)
        }
    }
    
    
    private func setupLayout() {
        self.addSubviews(
            logoImage,
            welcomeLabel,
            goToMainButton
        )
        
        logoImage.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(67)
            $0.centerX.equalToSuperview()
        }
        
        goToMainButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(50)
        }
    }
    
    //MARK: - Method
    
    func setWelcomeLableText(forID: String) {
        welcomeLabel.text = "\(forID)님\n반가워요!!"
    }
}

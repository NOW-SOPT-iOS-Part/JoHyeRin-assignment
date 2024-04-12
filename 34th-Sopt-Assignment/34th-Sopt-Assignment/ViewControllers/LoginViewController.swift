//
//  LoginViewConroller.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/11/24.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "TVING ID 로그인"
        label.font = .pretendardFont(weight: 500, size: 23)
        label.textColor = .tvingGray1
        
        return label
    }()
    
    private lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.setTextField(forBackgroundColor: .tvingGray4, forCornerRadius: 3)
        textField.setPlaceholder(placeholder: "아이디", fontColor: .tvingGray2, font: .pretendardFont(weight: 600, size: 15))
        
        return textField
    }()
    
    private lazy var pwTextField: UITextField = {
        let textField = UITextField()
        textField.setTextField(forBackgroundColor: .tvingGray4, forCornerRadius: 3)
        textField.setPlaceholder(placeholder: "비밀번호", fontColor: .tvingGray2, font: .pretendardFont(weight: 600, size: 15))
        
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setButton(forBackgroundColor: .black, forBorderColor: .tvingGray4, forBorderWidth: 1, forCornerRadius: 1)
        button.setButtonText(forText: "로그인하기", forfont: .pretendardFont(weight: 600, size: 14), forfontColor: .tvingGray2)
        
        return button
    }()
    
    private let findIdLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디 찾기"
        label.font = .pretendardFont(weight: 600, size: 14)
        label.textColor = .tvingGray2
        
        return label
    }()
    
    private let findPwLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 찾기"
        label.font = .pretendardFont(weight: 600, size: 14)
        label.textColor = .tvingGray2
        
        return label
    }()
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .tvingGray4
        view.snp.makeConstraints {
            $0.height.equalTo(12)
            $0.width.equalTo(1)
        }
        
        return view
    }()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 34
        
        return stackView
    }()
    
    private let accountLabel: UILabel = {
        let label = UILabel()
        label.text = "아직 계정이 없으신가요?"
        label.font = .pretendardFont(weight: 600, size: 14)
        label.textColor = .tvingGray3
        
        return label
    }()
    
    private lazy var createNicknameButton: UIButton = {
        let button = UIButton()
        button.setButtonText(forText: "닉네임 만들러가기", forfont: .pretendardFont(weight: 400, size: 14), forfontColor: .tvingGray2)
        button.underlineTitle(forTitle: button.titleLabel?.text ?? "")
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        setupLayout()
    }
}

extension LoginViewController {
    private func setupLayout() {
        self.view.addSubviews(
            loginLabel,
            idTextField,
            pwTextField,
            loginButton,
            labelStackView,
            accountLabel,
            createNicknameButton
        )
        
        labelStackView.addArrangedSubviews(findIdLabel, divider, findPwLabel)
        
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(90)
            $0.centerX.equalToSuperview()
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(31)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(52)
            $0.width.equalToSuperview().inset(20)
        }
        
        pwTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(7)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(52)
            $0.width.equalToSuperview().inset(20)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(21)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(52)
            $0.width.equalToSuperview().inset(20)
        }
        
        labelStackView.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(31)
            $0.centerX.equalToSuperview()
        }
        
        accountLabel.snp.makeConstraints {
            $0.top.equalTo(labelStackView.snp.bottom).offset(28)
            $0.leading.equalTo(labelStackView.snp.leading).offset(-35)
        }
        
        createNicknameButton.snp.makeConstraints {
            $0.top.equalTo(labelStackView.snp.bottom).offset(28)
            $0.trailing.equalTo(labelStackView.snp.trailing).offset(35)
            $0.height.equalTo(accountLabel.snp.height)
        }
    }
}

#Preview {
    LoginViewController()
}

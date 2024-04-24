//
//  LoginView.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/24/24.
//

import UIKit
import SnapKit
import Then

final class LoginView: UIView {
    
    //MARK: - Properties
    
    var isIdTextEmpty: Bool = true {
        didSet {
            if isIdTextEmpty {
                idClearButton.isHidden = true
                idTextField.layer.borderWidth = 0
                invalidEmailLabel.isHidden = true
            } else {
                idClearButton.isHidden = false
            }
        }
    }
    
    var isPwTextEmpty: Bool = true {
        didSet {
            if isPwTextEmpty {
                pwClearButton.alpha = 0
            } else {
                pwClearButton.alpha = 100
            }
        }
    }
    
    var isMaskButtonSelected: Bool = false {
        didSet {
            if isMaskButtonSelected {
                maskButton.setImage(UIImage(named: "hiddenEyeImage"), for: .normal)
                pwTextField.isSecureTextEntry = false
            } else {
                maskButton.setImage(UIImage(named: "shownEyeImage"), for: .normal)
                pwTextField.isSecureTextEntry = true
            }
        }
    }
    
    //MARK: - UI Properties
    
    private let loginLabel = UILabel()
    private lazy var idTextField = UITextField()
    private lazy var pwTextField = UITextField()
    lazy var idClearButton = UIButton()
    lazy var pwClearButton = UIButton()
    lazy var maskButton = UIButton()
    private lazy var buttonStackView = UIStackView()
    private lazy var textfieldStackView = UIStackView()
    private let invalidEmailLabel = UILabel()
    lazy var loginButton = UIButton()
    private let findIdLabel = UILabel()
    private let findPwLabel = UILabel()
    private let divider = UIView()
    private let labelStackView = UIStackView()
    private let accountLabel = UILabel()
    lazy var createNickNameButton = UIButton()
    
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

extension LoginView {
   
    // MARK: - Privat Method
    
    private func setupStyle() {
        self.backgroundColor = .black
        
        loginLabel.do {
            $0.text = "TVING ID 로그인"
            $0.font = .pretendardFont(weight: 500, size: 23)
            $0.textColor = .tvingGray1
        }
        
        idTextField.do {
            $0.setTextField(forBackgroundColor: .tvingGray4, forCornerRadius: 3)
            $0.setPlaceholder(placeholder: "아이디", fontColor: .tvingGray2, font: .pretendardFont(weight: 600, size: 15))
            $0.setTextFont(forFont: .pretendardFont(weight: 600, size: 15), forFontColor: .tvingGray2)
            $0.addPadding(left: 17)
            $0.tag = 1
            $0.autocapitalizationType = .none
            
            let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
            rightView.addSubview(idClearButton)
            $0.rightViewMode = .always
            $0.rightView = rightView
        }
        
        pwTextField.do {
            $0.setTextField(forBackgroundColor: .tvingGray4, forCornerRadius: 3)
            $0.setPlaceholder(placeholder: "비밀번호", fontColor: .tvingGray2, font: .pretendardFont(weight: 600, size: 15))
            $0.setTextFont(forFont: .pretendardFont(weight: 600, size: 15), forFontColor: .tvingGray2)
            $0.addPadding(left: 17)
            $0.tag = 2
            $0.isSecureTextEntry = true
            
            let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
            rightView.addSubviews(buttonStackView)
            $0.rightViewMode = .always
            $0.rightView = rightView
        }
        
        idClearButton.do {
            $0.setImage(UIImage(named: "clearButtonImage"), for: .normal)
            $0.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            $0.contentMode = .scaleAspectFit
            $0.tag = 1
            $0.isHidden = true
        }
        
        pwClearButton.do {
            $0.setImage(UIImage(named: "clearButtonImage"), for: .normal)
            $0.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            $0.contentMode = .scaleAspectFit
            $0.tag = 2
            $0.alpha = 0
        }
    
        maskButton.do {
            $0.setImage(UIImage(named: "shownEyeImage"), for: .normal)
            $0.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            $0.contentMode = .scaleAspectFit
        }
        
        buttonStackView.do {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        }
        
        textfieldStackView.do {
            $0.axis = .vertical
            $0.spacing = 7
        }
        
        invalidEmailLabel.do {
            $0.text = "올바르지 않은 형식의 이메일입니다!"
            $0.textColor = .tvingRed
            $0.font = .pretendardFont(weight: 500, size: 13)
            $0.isHidden = true
        }
        
        loginButton.do {
            $0.setButton(forBackgroundColor: .black, forBorderColor: .tvingGray4, forBorderWidth: 1, forCornerRadius: 3)
            $0.setButtonText(forText: "로그인하기", forfont: .pretendardFont(weight: 600, size: 14), forfontColor: .tvingGray2)
            $0.isEnabled = false
        }
        
        findIdLabel.do {
            $0.text = "아이디 찾기"
            $0.font = .pretendardFont(weight: 600, size: 14)
            $0.textColor = .tvingGray2
        }
        
        findPwLabel.do {
            $0.text = "비밀번호 찾기"
            $0.font = .pretendardFont(weight: 600, size: 14)
            $0.textColor = .tvingGray2
        }
        
        divider.do {
            $0.backgroundColor = .tvingGray4
            $0.snp.makeConstraints {
                $0.height.equalTo(12)
                $0.width.equalTo(1)
            }
        }
        
        labelStackView.do {
            $0.axis = .horizontal
            $0.spacing = 34
        }
        
        accountLabel.do {
            $0.text = "아직 계정이 없으신가요?"
            $0.font = .pretendardFont(weight: 600, size: 14)
            $0.textColor = .tvingGray3
        }
        
        createNickNameButton.do {
            $0.setButtonText(forText: "닉네임 만들러가기", forfont: .pretendardFont(weight: 400, size: 14))
            $0.underlineTitle(forTitle: $0.titleLabel?.text ?? "")
            $0.setTitleColor(.tvingGray2, for: .normal)
        }
    }
    
    private func setupLayout() {
        self.addSubviews(
            loginLabel,
            textfieldStackView,
            invalidEmailLabel,
            loginButton,
            labelStackView,
            accountLabel,
            createNickNameButton
        )
        
        textfieldStackView.addArrangedSubviews(idTextField, invalidEmailLabel, pwTextField)
        labelStackView.addArrangedSubviews(findIdLabel, divider, findPwLabel)
        buttonStackView.addArrangedSubviews(pwClearButton, maskButton)
        
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(50)
            $0.centerX.equalToSuperview()
        }
        
        textfieldStackView.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(31)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        idTextField.snp.makeConstraints {
            $0.height.equalTo(52)
        }
        
        pwTextField.snp.makeConstraints {
            $0.height.equalTo(52)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(textfieldStackView.snp.bottom).offset(21)
            $0.height.equalTo(52)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        labelStackView.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(31)
            $0.centerX.equalToSuperview()
        }
        
        accountLabel.snp.makeConstraints {
            $0.top.equalTo(labelStackView.snp.bottom).offset(28)
            $0.leading.equalTo(labelStackView.snp.leading).offset(-35)
        }
        
        createNickNameButton.snp.makeConstraints {
            $0.top.equalTo(labelStackView.snp.bottom).offset(28)
            $0.trailing.equalTo(labelStackView.snp.trailing).offset(35)
            $0.height.equalTo(accountLabel.snp.height)
        }
    }
    
    //MARK: - Method
    
    func setupTextFieldDelegate(forDelegate: UITextFieldDelegate) {
        idTextField.delegate = forDelegate
        pwTextField.delegate = forDelegate
    }
    
    func clearTextField(forTag: Int) {
        if forTag == 1 {
            idTextField.text = ""
            isIdTextEmpty = true
        } else {
            pwTextField.text = ""
            isPwTextEmpty = true
        }
    }
    
    func getTextFieldText(forTag: Int) -> String {
        if forTag == 1 {
            guard let idText = idTextField.text else {
                return ""
            }
            return idText
        } else {
            guard let pwText = pwTextField.text else {
                return ""
            }
            return pwText
        }
    }
    
    func isHiddenInvalidEmailLabel(isHidden: Bool) {
        if isHidden {
            invalidEmailLabel.isHidden = isHidden
        } else {
            invalidEmailLabel.isHidden = isHidden
            idTextField.makeBorder(width: 1, color: .tvingRed)
        }
    }
    
    func updateLoginButtonEnable(isEnable: Bool) {
        if isEnable {
            loginButton.isEnabled = true
            loginButton.setButton(forBackgroundColor: .tvingRed, forBorderWidth: 0, forCornerRadius: 3)
            loginButton.setTitleColor(.white, for: .normal)
        } else {
            loginButton.isEnabled = false
            loginButton.setButton(forBackgroundColor: .black, forBorderColor: .tvingGray4, forBorderWidth: 1, forCornerRadius: 3)
            loginButton.setTitleColor(.tvingGray2, for: .normal)
        }
    }
}

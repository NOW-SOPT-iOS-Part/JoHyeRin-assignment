//
//  LoginViewConroller.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/11/24.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    
    private lazy var isIdTextEmpty: Bool = true {
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
    
    private lazy var isPwTextEmpty: Bool = true {
        didSet {
            if isPwTextEmpty {
                pwClearButton.alpha = 0
            } else {
                pwClearButton.alpha = 100
            }
        }
    }
    
    private lazy var isMaskButtonSelected: Bool = false {
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
        textField.setTextFont(forFont: .pretendardFont(weight: 600, size: 15), forFontColor: .tvingGray2)
        textField.addPadding(left: 17)
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        rightView.addSubview(idClearButton)
        textField.rightViewMode = .always
        textField.rightView = rightView
        
        return textField
    }()
    
    private lazy var pwTextField: UITextField = {
        let textField = UITextField()
        textField.setTextField(forBackgroundColor: .tvingGray4, forCornerRadius: 3)
        textField.setPlaceholder(placeholder: "비밀번호", fontColor: .tvingGray2, font: .pretendardFont(weight: 600, size: 15))
        textField.setTextFont(forFont: .pretendardFont(weight: 600, size: 15), forFontColor: .tvingGray2)
        textField.addPadding(left: 17)
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
        rightView.addSubviews(buttonStackView)
        textField.rightViewMode = .always
        textField.rightView = rightView
        
        return textField
    }()
    
    private lazy var idClearButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "clearButtonImage"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.contentMode = .scaleAspectFit
        button.tag = 1
        button.isHidden = true
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var pwClearButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "clearButtonImage"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.contentMode = .scaleAspectFit
        button.tag = 2
        button.alpha = 0
        button.addTarget(self, action: #selector(clearButtonTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var maskButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "shownEyeImage"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(maskButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        
        return stackView
    }()
    
    private lazy var textfieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 7
        
        return stackView
    }()
    
    private let invalidEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "올바르지 않은 형식의 이메일입니다!"
        label.textColor = .tvingRed
        label.font = .pretendardFont(weight: 500, size: 13)
        label.isHidden = true
        
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setButton(forBackgroundColor: .black, forBorderColor: .tvingGray4, forBorderWidth: 1, forCornerRadius: 3)
        button.setButtonText(forText: "로그인하기", forfont: .pretendardFont(weight: 600, size: 14), forfontColor: .tvingGray2)
        button.isEnabled = false
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
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
    
    private lazy var createNickNameButton: UIButton = {
        let button = UIButton()
        button.setButtonText(forText: "닉네임 만들러가기", forfont: .pretendardFont(weight: 400, size: 14))
        button.underlineTitle(forTitle: button.titleLabel?.text ?? "")
        button.setTitleColor(.tvingGray2, for: .normal)
        button.addTarget(self, action: #selector(createNickNameButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        hideKeyboard()
        setupLayout()
    }
}

extension LoginViewController {
    private func setupLayout() {
        self.view.addSubviews(
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
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(50)
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
    
    private func isValidEmail(forEmail: String?) -> (Bool) {
        guard forEmail != nil else { return false }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return pred.evaluate(with: forEmail)
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.tvingGray2.cgColor
        if textField == idTextField {
            invalidEmailLabel.isHidden = true
        }
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let idText = idTextField.text, let pwText = pwTextField.text {
            isIdTextEmpty = idText.isEmpty
            isPwTextEmpty = pwText.isEmpty
            
            if !idText.isEmpty && !pwText.isEmpty {
                loginButton.isEnabled = true
                loginButton.setButton(forBackgroundColor: .tvingRed, forBorderWidth: 0, forCornerRadius: 3)
            } else {
                loginButton.isEnabled = false
                loginButton.setButton(forBackgroundColor: .black, forBorderColor: .tvingGray4, forBorderWidth: 1, forCornerRadius: 3)
                loginButton.titleLabel?.textColor = .white
            }
        }
    }
    
    @objc func maskButtonTapped() {
        isMaskButtonSelected.toggle()
    }
    
    @objc func clearButtonTapped(_ button: UIButton) {
        switch button.tag {
        case 1:
            idTextField.text = ""
            isIdTextEmpty = true
        case 2:
            pwTextField.text = ""
            isPwTextEmpty = true
        default:
            break
        }
        loginButton.setButton(forBackgroundColor: .black, forBorderColor: .tvingGray4, forBorderWidth: 1, forCornerRadius: 1)
    }
    
    @objc func loginButtonTapped() {
        let welcomViewController = WelcomeViewController()
        
        let idText = idTextField.text
        if isValidEmail(forEmail: idText) {
            welcomViewController.id = idText
            navigationController?.pushViewController(welcomViewController, animated: true)
        } else {
            invalidEmailLabel.isHidden = false
            idTextField.layer.borderWidth = 1
            idTextField.layer.borderColor = UIColor.tvingRed.cgColor
        }
    }
    
    @objc func createNickNameButtonTapped() {
        let nickNameModalViewController = NickNameModalViewController()
        
        if let sheet = nickNameModalViewController.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        
        self.present(nickNameModalViewController, animated: true)
    }
}

//
//  NickNameViewController.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/19/24.
//

import UIKit
import SnapKit

final class NickNameModalViewController: UIViewController {
    
    private lazy var isNickNameTextEmpty: Bool = true {
        didSet {
            if isNickNameTextEmpty {
                invalidNickLabel.isHidden = true
                nickNameTextField.layer.borderWidth = 0
            } else {
                clearButton.isHidden = false
            }
        }
    }
    
    private let nickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임 설정하기"
        label.font = .pretendardFont(weight: 500, size: 23)
        
        return label
    }()
    
    private lazy var nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.setTextField(forBackgroundColor: .tvingGray1, forCornerRadius: 7)
        textField.setPlaceholder(placeholder: "닉네임을 2~7자의 한글로 입력해주세요!", fontColor: .tvingGray2, font: .pretendardFont(weight: 600, size: 15))
        textField.setTextFont(forFont: .pretendardFont(weight: 600, size: 15), forFontColor: .black)
        textField.addPadding(left: 17)
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        rightView.addSubview(clearButton)
        textField.rightViewMode = .always
        textField.rightView = rightView
        
        return textField
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "clearButtonImage"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.contentMode = .scaleAspectFit
        button.tag = 1
        button.isHidden = true
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let invalidNickLabel: UILabel = {
        let label = UILabel()
        label.text = "올바르지 않은 형식의 닉네임입니다! (2~7자의 한글)"
        label.textColor = .tvingRed
        label.font = .pretendardFont(weight: 500, size: 13)
        label.isHidden = true
        
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setButton(forBackgroundColor: .tvingGray3, forCornerRadius: 10)
        button.setButtonText(forText: "저장하기", forfont: .pretendardFont(weight: 600, size: 14), forfontColor: .white)
        button.isEnabled = false
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyle()
        setupLayout()
    }
}

extension NickNameModalViewController {
    private func setupStyle() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
    }
    
    private func setupLayout() {
        self.view.addSubviews(
            nickNameLabel,
            nickNameTextField,
            invalidNickLabel,
            saveButton
        )
        
        nickNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(45)
            $0.leading.equalToSuperview().inset(20)
        }
        
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(21)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        
        invalidNickLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(7)
            $0.leading.equalToSuperview().inset(20)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(230)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
    }
    
    private func isValidNickName(forNickName: String?) -> (Bool) {
        guard forNickName != nil else { return false }
        
        let nickRegEx = "[가-힣]{2,7}"
        let pred = NSPredicate(format:"SELF MATCHES %@", nickRegEx)
        return pred.evaluate(with: forNickName)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let nickNameText = nickNameTextField.text {
            isNickNameTextEmpty = nickNameText.isEmpty
            
            if nickNameText.isEmpty || isValidNickName(forNickName: nickNameText){
                invalidNickLabel.isHidden = true
                nickNameTextField.layer.borderWidth = 0
                saveButton.isEnabled = true
                saveButton.backgroundColor = .tvingRed
            } else {
                invalidNickLabel.isHidden = false
                nickNameTextField.layer.borderWidth = 1
                nickNameTextField.layer.borderColor = UIColor.tvingRed.cgColor
                saveButton.isEnabled = false
                saveButton.backgroundColor = .tvingGray3
                saveButton.titleLabel?.textColor = .white
            }
        }
    }
    
    @objc func clearButtonTapped(_ button: UIButton) {
        nickNameTextField.text = ""
        isNickNameTextEmpty = true
        saveButton.backgroundColor = .tvingGray2
        saveButton.titleLabel?.textColor = .white
    }
    
    @objc func saveButtonTapped() {
        let nickText = nickNameTextField.text
        if isValidNickName(forNickName: nickText) {
            
        } else {
            invalidNickLabel.isHidden = false
            nickNameTextField.layer.borderWidth = 1
            nickNameTextField.layer.borderColor = UIColor.tvingRed.cgColor
        }
    }
}

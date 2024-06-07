//
//  NickNameModalView.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/24/24.
//

import UIKit

import SnapKit
import Then

final class NickNameModalView: UIView {
    
    //MARK: - Properties
    
    var isNickNameTextEmpty: Bool = true {
        didSet {
            if isNickNameTextEmpty {
                invalidNickLabel.isHidden = true
                nickNameTextField.layer.borderWidth = 0
            } else {
                clearButton.isHidden = false
            }
        }
    }
    
    //MARK: - UI Properties
    
    private let nickNameLabel = UILabel()
    private lazy var nickNameTextField = UITextField()
    lazy var clearButton = UIButton()
    private let invalidNickLabel = UILabel()
    lazy var saveButton = UIButton()
    
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
extension NickNameModalView {
    
    // MARK: - Private Method
    
    private func setupStyle() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 30
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.layer.masksToBounds = true
        
        nickNameLabel.do {
            $0.text = "닉네임 설정하기"
            $0.font = .pretendardFont(weight: 500, size: 23)
        }
        
        nickNameTextField.do {
            $0.setTextField(forBackgroundColor: .tvingGray1, forCornerRadius: 7)
            $0.setPlaceholder(placeholder: "닉네임을 2~7자의 한글로 입력해주세요!", fontColor: .tvingGray2, font: .pretendardFont(weight: 600, size: 15))
            $0.setTextFont(forFont: .pretendardFont(weight: 600, size: 15), forFontColor: .black)
            $0.addPadding(left: 17)
            
            let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
            rightView.addSubview(clearButton)
            $0.rightViewMode = .always
            $0.rightView = rightView
        }
        
        clearButton.do {
            $0.setImage(UIImage(named: "clearButtonImage"), for: .normal)
            $0.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            $0.contentMode = .scaleAspectFit
            $0.tag = 1
            $0.isHidden = true
        }
        
        invalidNickLabel.do {
            $0.text = "올바르지 않은 형식의 닉네임입니다! (2~7자의 한글)"
            $0.textColor = .tvingRed
            $0.font = .pretendardFont(weight: 500, size: 13)
            $0.isHidden = true
        }
        
        saveButton.do {
            $0.setButton(forBackgroundColor: .tvingGray2, forCornerRadius: 10)
            $0.setButtonText(forText: "저장하기", forfont: .pretendardFont(weight: 600, size: 14), forfontColor: .white)
            $0.isEnabled = false
        }
    }
    
    private func setupHierarchy() {
        self.addSubviews(
            nickNameLabel,
            nickNameTextField,
            invalidNickLabel,
            saveButton
        )
    }
    
    private func setupLayout() {
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
    
    //MARK: - Method
    
    func setupTextFieldDelegate(forDelegate: UITextFieldDelegate) {
        nickNameTextField.delegate = forDelegate
    }
    
    func clearTextField() {
        nickNameTextField.text = ""
        isNickNameTextEmpty = true
    }
    
    func getTextFieldText() -> String {
        guard let nickNameText = nickNameTextField.text else {
            return ""
        }
        return nickNameText
    }
    
    func isHiddenInvalidEmailLabel(isHidden: Bool) {
        if isHidden {
            invalidNickLabel.isHidden = true
            nickNameTextField.layer.borderWidth = 0
        } else {
            invalidNickLabel.isHidden = false
            nickNameTextField.makeBorder(width: 1, color: .tvingRed)
        }
    }
    
    func updateLoginButtonEnable(isEnable: Bool) {
        if isEnable {
            saveButton.isEnabled = true
            saveButton.backgroundColor = .tvingRed
            saveButton.setTitleColor(.white, for: .normal)
        } else {
            saveButton.isEnabled = false
            saveButton.backgroundColor = .tvingGray2
            saveButton.setTitleColor(.white, for: .normal)
        }
    }
}

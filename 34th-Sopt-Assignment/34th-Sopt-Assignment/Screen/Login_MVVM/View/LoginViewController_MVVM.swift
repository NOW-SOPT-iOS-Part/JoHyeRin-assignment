//
//  LoginViewController_MVVM.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 6/7/24.
//

import UIKit

final class LoginViewController_MVVM: UIViewController {
    
    //MARK: - Properties
    
    var setNickNameFlag = false
    var nickNameText = ""
    
    private let rootView = LoginView()
    private let viewModel = LoginViewModel()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboard()
        setAddTarget()
        setDelegate()
    }
}

extension LoginViewController_MVVM {
    
    // MARK: - Private Method
    
    private func setAddTarget() {
        rootView.idClearButton.addTarget(self, action: #selector(clearButtonTapped(_:)), for: .touchUpInside)
        rootView.pwClearButton.addTarget(self, action: #selector(clearButtonTapped(_:)), for: .touchUpInside)
        rootView.maskButton.addTarget(self, action: #selector(maskButtonTapped), for: .touchUpInside)
        rootView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        rootView.createNickNameButton.addTarget(self, action: #selector(createNickNameButtonTapped), for: .touchUpInside)
    }
    
    private func setDelegate() {
        rootView.setupTextFieldDelegate(forDelegate: self)
    }
    
    //MARK: - Objc Method
    
    @objc func maskButtonTapped() {
        rootView.isMaskButtonSelected.toggle()
    }
    
    @objc func clearButtonTapped(_ button: UIButton) {
        if button == rootView.idClearButton {
            rootView.clearTextField(forTag: 1)
        } else {
            rootView.clearTextField(forTag: 2)
        }
        rootView.updateLoginButtonEnable(isEnable: false)
    }
    
    @objc func loginButtonTapped() {
        let welcomViewController = WelcomeViewController()
        
        let idText = rootView.getTextFieldText(forTag: 1)
        if viewModel.isValidEmail(forEmail: idText) {
            if setNickNameFlag {
                welcomViewController.id = nickNameText
            }else {
                welcomViewController.id = idText
            }
            navigationController?.pushViewController(welcomViewController, animated: true)
        } else {
            rootView.isHiddenInvalidEmailLabel(isHidden: false)
        }
    }
    
    @objc func createNickNameButtonTapped() {
        let nickNameModalViewController = NickNameModalViewController_MVVM()
        nickNameModalViewController.delegate = self
        if let sheet = nickNameModalViewController.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        
        self.present(nickNameModalViewController, animated: true)
    }
}

//MARK: - TextField Delegate

extension LoginViewController_MVVM: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.makeBorder(width: 1, color: .tvingGray2)
        if textField.tag == 1 {
            rootView.isHiddenInvalidEmailLabel(isHidden: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.layer.borderWidth = 0
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let idText = rootView.getTextFieldText(forTag: 1)
        let pwText = rootView.getTextFieldText(forTag: 2)
        rootView.isIdTextEmpty = idText.isEmpty
        rootView.isPwTextEmpty = pwText.isEmpty
        
        if !idText.isEmpty && !pwText.isEmpty {
            rootView.updateLoginButtonEnable(isEnable: true)
        } else {
            rootView.updateLoginButtonEnable(isEnable: false)
        }
    }
}

//MARK: - NickNameProtocol

extension LoginViewController_MVVM: nickNameProtocol_MVVM {
    func setupNickName(nickname: String?, isComplete: Bool?) {
        if let nickname {
            nickNameText = nickname
        }
        
        if let isComplete {
            setNickNameFlag = isComplete
        }
    }
}

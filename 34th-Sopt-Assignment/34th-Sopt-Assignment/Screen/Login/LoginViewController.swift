//
//  LoginViewConroller.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/11/24.
//

import UIKit

final class LoginViewController: UIViewController {
    
    //MARK: - Properties
    
    var setNickNameFlag = false
    var nickNameText = ""
    
    private let rootView = LoginView()
    
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

extension LoginViewController {
    
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
    
    private func isValidEmail(forEmail: String?) -> (Bool) {
        guard forEmail != nil else { return false }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return pred.evaluate(with: forEmail)
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
        if isValidEmail(forEmail: idText) {
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
        let nickNameModalViewController = NickNameModalViewController()
        nickNameModalViewController.delegate = self
        if let sheet = nickNameModalViewController.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        
        self.present(nickNameModalViewController, animated: true)
    }
}

//MARK: - TextField Delegate

extension LoginViewController: UITextFieldDelegate {
    
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

extension LoginViewController: nickNameProtocol {
    func setupNickName(nickname: String?, isComplete: Bool?) {
        if let nickname {
            nickNameText = nickname
        }
        
        if let isComplete {
            setNickNameFlag = isComplete
        }
    }
}

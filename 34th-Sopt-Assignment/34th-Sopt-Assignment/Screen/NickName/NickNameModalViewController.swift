//
//  NickNameViewController.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/19/24.
//

import UIKit

protocol nickNameProtocol: AnyObject {
    func setupNickName(nickname: String?, isComplete: Bool?)
}

final class NickNameModalViewController: UIViewController {
    
    //MARK: - Properties
    
    weak var delegate: nickNameProtocol?
    
    private let rootView = NickNameModalView()

    //MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAddTarget()
        setDelegate()
    }
}

extension NickNameModalViewController {
    
    // MARK: - Private Method
    
    private func setAddTarget() {
        rootView.clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        rootView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    private func setDelegate() {
        rootView.setupTextFieldDelegate(forDelegate: self)
    }
    
    private func isValidNickName(forNickName: String?) -> (Bool) {
        guard forNickName != nil else { return false }
        
        let nickRegEx = "[가-힣]{2,7}"
        let pred = NSPredicate(format:"SELF MATCHES %@", nickRegEx)
        return pred.evaluate(with: forNickName)
    }
    
    //MARK: - Objc Method
    
    @objc func clearButtonTapped(_ button: UIButton) {
        rootView.clearTextField()
        rootView.updateLoginButtonEnable(isEnable: false)
    }
    
    @objc func saveButtonTapped() {
        let nickText = rootView.getTextFieldText()
        let setNickNameFlag = true
        if isValidNickName(forNickName: nickText) {
            delegate?.setupNickName(nickname: nickText, isComplete: setNickNameFlag)
        } else {
            rootView.isHiddenInvalidEmailLabel(isHidden: false)
        }
        self.dismiss(animated: true)
    }
}

extension NickNameModalViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let nickNameText = rootView.getTextFieldText()
        
        rootView.isNickNameTextEmpty = nickNameText.isEmpty
        
        if nickNameText.isEmpty {
            rootView.isHiddenInvalidEmailLabel(isHidden: true)
            rootView.updateLoginButtonEnable(isEnable: false)
        } else if isValidNickName(forNickName: nickNameText) {
            rootView.isHiddenInvalidEmailLabel(isHidden: true)
            rootView.updateLoginButtonEnable(isEnable: true)
        } else {
            rootView.isHiddenInvalidEmailLabel(isHidden: false)
            rootView.updateLoginButtonEnable(isEnable: false)
        }
    }
}

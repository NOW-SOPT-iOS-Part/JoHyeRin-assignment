//
//  NickNameModalViewController_MVVM.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 6/7/24.
//

import UIKit

protocol nickNameProtocol_MVVM: AnyObject {
    func setupNickName(nickname: String?, isComplete: Bool?)
}

final class NickNameModalViewController_MVVM: UIViewController {
    
    //MARK: - Properties
    
    weak var delegate: nickNameProtocol_MVVM?
    
    private let rootView = NickNameModalView()
    private let viewModel = NickNameModalViewModel()

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

extension NickNameModalViewController_MVVM {
    
    // MARK: - Private Method
    
    private func setAddTarget() {
        rootView.clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        rootView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    private func setDelegate() {
        rootView.setupTextFieldDelegate(forDelegate: self)
    }
    
    //MARK: - Objc Method
    
    @objc func clearButtonTapped(_ button: UIButton) {
        rootView.clearTextField()
        rootView.updateLoginButtonEnable(isEnable: false)
    }
    
    @objc func saveButtonTapped() {
        let nickText = rootView.getTextFieldText()
        let setNickNameFlag = true
        if viewModel.isValidNickName(forNickName: nickText) {
            delegate?.setupNickName(nickname: nickText, isComplete: setNickNameFlag)
        } else {
            rootView.isHiddenInvalidEmailLabel(isHidden: false)
        }
        self.dismiss(animated: true)
    }
}

extension NickNameModalViewController_MVVM: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let nickNameText = rootView.getTextFieldText()
        
        rootView.isNickNameTextEmpty = nickNameText.isEmpty
        
        if nickNameText.isEmpty {
            rootView.isHiddenInvalidEmailLabel(isHidden: true)
            rootView.updateLoginButtonEnable(isEnable: false)
        } else if viewModel.isValidNickName(forNickName: nickNameText) {
            rootView.isHiddenInvalidEmailLabel(isHidden: true)
            rootView.updateLoginButtonEnable(isEnable: true)
        } else {
            rootView.isHiddenInvalidEmailLabel(isHidden: false)
            rootView.updateLoginButtonEnable(isEnable: false)
        }
    }
}

//
//  welcomeViewController.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 4/14/24.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    //MARK: - Properties
    
    var id: String?
    
    private let rootView = WelecomeView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        setAddTarget()
        bindID()
    }
}

extension WelcomeViewController {
    
    // MARK: - Privat Method
    
    private func setAddTarget() {
        rootView.goToMainButton.addTarget(self, action: #selector(gotoMainButtonTapped), for: .touchUpInside)

    }
    
    private func bindID() {
        if let id {
            rootView.setWelcomeLableText(forID: id)
        }
    }
    
    @objc func gotoMainButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

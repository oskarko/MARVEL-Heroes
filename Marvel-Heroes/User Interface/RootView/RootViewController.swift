//  RootViewController.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

protocol RootViewControllerProtocol: AnyObject {

}

class RootViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: RootViewModel!
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    

    // MARK: - Selectors

    
    // MARK: - Helpers

    private func configureUI() {
        view.backgroundColor = .systemPurple

    }
    
}

// MARK: - RootViewControllerProtocol

extension RootViewController: RootViewControllerProtocol {

}
//  AlertViewController.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: AlertViewModel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var acceptButton: UIButton!
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    

    // MARK: - Selectors
    @IBAction func acceptButtonTapped(_ sender: UIButton) {
        viewModel.acceptButtonTapped()
    }
    
    
    // MARK: - Helpers

    private func configureUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        textLabel.text = viewModel.getInfoText()
        textLabelHeight.constant = textLabel.requiredHeight
        acceptButton.setTitle("Accept".localized(), for: .normal)
    }
    
}

// MARK: - AlertViewControllerProtocol

protocol AlertViewControllerProtocol: AnyObject { }
extension AlertViewController: AlertViewControllerProtocol { }

//  DetailsViewController.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

protocol DetailsViewControllerProtocol: AnyObject {

}

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: DetailsViewModel!
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var recruitButton: UIButton!
    @IBOutlet weak var characterHistoryLabel: UILabel!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillLayoutSubviews() {
        characterHistoryLabel.sizeToFit()
    }

    // MARK: - Selectors

    @IBAction func recruitButtonTapped(_ sender: UIButton) {
        print("recruit")
    }
    
    // MARK: - Helpers

    private func configureUI() {
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        characterNameLabel.text = viewModel.getCharacterName()
        characterHistoryLabel.text = viewModel.getCharacterHistory()
        recruitButton.setTitle("💪  Recruit to Squad", for: .normal)
        
        if let urlString = viewModel.getCharacterImageUrlString() {
            characterImageView.sd_setImage(with: URL(string: urlString))
        } else  {
            characterImageView.image = UIImage(named: "imageNotAvailable")
        }
    }
    
}

// MARK: - DetailsViewControllerProtocol

extension DetailsViewController: DetailsViewControllerProtocol {

}

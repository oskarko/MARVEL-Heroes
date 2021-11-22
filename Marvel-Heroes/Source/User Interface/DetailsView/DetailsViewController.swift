//  DetailsViewController.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

enum CharacterStatus: Int {
    case free
    case hired
}

protocol DetailsViewControllerProtocol: AnyObject {
    func updateUI(characterStatus: CharacterStatus)
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
        updateUI(characterStatus: viewModel.getCharacterStatus())
    }
    
    override func viewWillLayoutSubviews() {
        characterHistoryLabel.sizeToFit()
    }

    // MARK: - Selectors

    @IBAction func recruitButtonTapped(_ sender: UIButton) {
        viewModel.recruitButtonTapped()
    }
    
    // MARK: - Helpers

    private func configureUI() {
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        characterNameLabel.text = viewModel.getCharacterName()
        characterHistoryLabel.text = viewModel.getCharacterHistory()
        
        if let urlString = viewModel.getCharacterImageUrlString() {
            characterImageView.sd_setImage(with: URL(string: urlString))
        } else  {
            // Default UIImage if the API does NOT provide anyone.
            characterImageView.image = UIImage(named: "imageNotAvailable")
        }
    }
    
}

// MARK: - DetailsViewControllerProtocol

extension DetailsViewController: DetailsViewControllerProtocol {
    // Setup the recruitButton UI depending on the character status
    func updateUI(characterStatus: CharacterStatus) {
        recruitButton.setTitle(viewModel.getRecruitButtonTitle(), for: .normal)
        recruitButton.backgroundColor = characterStatus == .free ? .marvelRedLight : .marvelBackground
        recruitButton.layer.borderWidth = characterStatus == .free ? 0 : 2
        recruitButton.layer.borderColor = characterStatus == .free ? UIColor.marvelBackground?.cgColor : UIColor.marvelRedLight?.cgColor
    }
}

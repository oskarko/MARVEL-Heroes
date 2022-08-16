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
    func dismissActivityIndicator()
    func updateUI(characterStatus: CharacterStatus)
}

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    static let statusBarAlpha: CGFloat = 0.3
    
    var viewModel: DetailsViewModel
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var recruitButton: UIButton!
    @IBOutlet weak var characterHistoryLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Lifecycle
    
    init(_ viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        viewModel.fetchCharacter()
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
        setupStatusBar()
        setupNavigationController()
        activityIndicator.startAnimating()
    }
    
    private func setupStatusBar() {
        let height = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let statusBarView = UIView(frame: CGRect(x: .zero, y: .zero, width: view.frame.size.width, height: height))
        statusBarView.backgroundColor = .black
        statusBarView.alpha = Self.statusBarAlpha
        view.addSubview(statusBarView)
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
}

// MARK: - DetailsViewControllerProtocol

extension DetailsViewController: DetailsViewControllerProtocol {
    
    func dismissActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAndHide()
        }
    }
    
    // Setup the recruitButton UI depending on the character status
    func updateUI(characterStatus: CharacterStatus) {
        DispatchQueue.main.async {
            [self.characterNameLabel, self.recruitButton, self.characterHistoryLabel].forEach {
                $0?.isHidden = false
            }
            self.recruitButton.setTitle(self.viewModel.getRecruitButtonTitle(), for: .normal)
            self.recruitButton.backgroundColor = characterStatus == .free ? .marvelRedLight : .marvelBackground
            self.recruitButton.layer.borderWidth = characterStatus == .free ? 0 : 2
            self.recruitButton.layer.borderColor = characterStatus == .free ? UIColor.marvelBackground?.cgColor : UIColor.marvelRedLight?.cgColor
            
            self.characterNameLabel.text = self.viewModel.getCharacterName()
            self.characterHistoryLabel.text = self.viewModel.getCharacterHistory()
            
            if let urlString = self.viewModel.getCharacterImageUrlString() {
                self.characterImageView.sd_setImage(with: URL(string: urlString))
            } else  {
                // Default UIImage if the API does NOT provide anyone.
                self.characterImageView.image = UIImage(named: "imageNotAvailable")
            }
        }
    }
}

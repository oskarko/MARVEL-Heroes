//  RootViewController.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

protocol RootViewControllerProtocol: AnyObject {
    func reloadData()
    func insertItems(at indexPathsToReload: [IndexPath])
}

class RootViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: RootViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureUI()
        viewModel.fetchCharacters(offset: 0)
    }
    

    // MARK: - Selectors

    
    // MARK: - Helpers

    private func configureTableView() {
        tableView.register(UINib(nibName: CharacterCell.identifier, bundle: nil),
                           forCellReuseIdentifier: CharacterCell.identifier)
        tableView.tableFooterView = UIView()
    }
    
    private func configureUI() {

    }
    
}

// MARK: - RootViewControllerProtocol

extension RootViewController: RootViewControllerProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func insertItems(at indexPathsToReload: [IndexPath]) {
        DispatchQueue.main.async {
            self.tableView.insertRows(at: indexPathsToReload, with: .none)
        }
    }
}

// MARK: - UITableViewDataSource && UITableViewDelegate

extension RootViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfCharacters
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else {
            assertionFailure("Could not deque cell")
            return UITableViewCell()
        }
        
        cell.configure(with: viewModel.cellModel(at: indexPath.row))
        //cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

}

// MARK: - UITableViewDataSourcePrefetching

extension RootViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        // If We're in the last cell, We'll try to fetch automatically
        // the next characters in order to have an infinite scrolling effect.
        viewModel.prefetchRows(at: indexPaths)
    }
}

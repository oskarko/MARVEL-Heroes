//
//  RootHeaderView.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

protocol RootHeaderViewDelegate: AnyObject {
    func didSelectItem(at character: Character)
}

class RootHeaderView: UIView {
    
    static let identifier = "RootHeaderView"
    static let squadCellWidth: CGFloat = 72
    static let squadCellHeight: CGFloat = 116
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var characters: [Character]?
    weak var delegate: RootHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(Self.identifier, owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        titleLabel.text = "My Squad"
        
        collectionView.register(UINib(nibName: SquadMemberCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: SquadMemberCell.identifier)
        collectionView.contentInset = UIEdgeInsets(
            top: .zero,
            left: COLLECTION_VIEW_PADDING,
            bottom: .zero,
            right: COLLECTION_VIEW_PADDING
        )
    }
    
    func configure(with characters: [Character]) {
        self.characters = characters
        collectionView.reloadData()
    }
}

// MARK: - CollectionView Delegate & DataSource
extension RootHeaderView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SquadMemberCell.identifier, for: indexPath
        ) as? SquadMemberCell else {
            assertionFailure("Could not deque cell")
            return UICollectionViewCell()
        }
        guard let characters = characters, indexPath.row < characters.count else {
            assertionFailure("Characters array was corrupted")
            return UICollectionViewCell()
        }
        cell.configure(with: characters[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let characters = characters else { return }
        
        let character = characters[indexPath.row]
        delegate?.didSelectItem(at: character)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Self.squadCellWidth, height: Self.squadCellHeight)
    }
}

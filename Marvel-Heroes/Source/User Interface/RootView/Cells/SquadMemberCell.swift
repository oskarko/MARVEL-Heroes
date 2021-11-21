//
//  SquadMemberCell.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

class SquadMemberCell: UICollectionViewCell {

    static let identifier = "SquadMemberCell"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with character: Character) {
        characterNameLabel.text = character.name
        characterImageView.layer.cornerRadius = characterImageView.frame.height / 2
        
        guard let path = character.thumbnail?.path,
              let fileExtension = character.thumbnail?.fileExtension?.description,
              let url = URL(string: path + "." + fileExtension),
              !path.contains("image_not_available") else {

            characterImageView.image = UIImage(named: "imageNotAvailable")
            return
        }

        characterImageView.sd_setImage(with: url)
    }

}

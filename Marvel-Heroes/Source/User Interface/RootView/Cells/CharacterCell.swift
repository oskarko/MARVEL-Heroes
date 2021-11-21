//
//  CharacterCell.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import SDWebImage
import UIKit

class CharacterCell: UITableViewCell {

    static let identifier = "CharacterCell"

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterLabel: UILabel!
    
    func configure(with character: Character) {
        characterLabel.text = character.name
        
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

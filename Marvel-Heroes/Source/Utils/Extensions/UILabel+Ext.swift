//
//  UILabel+Ext.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import UIKit

extension UILabel {
    
    public var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0,
                                          y: 0,
                                          width: frame.width,
                                          height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        
        return label.frame.height
    }
}

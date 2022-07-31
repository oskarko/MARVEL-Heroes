//
//  UIActivityIndicatorView+Ext.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    func stopAndHide() {
        stopAnimating()
        isHidden = true
    }
}

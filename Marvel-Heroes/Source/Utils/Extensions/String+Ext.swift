//
//  String+Ext.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import CryptoKit
import Foundation

extension String {

    /// Short form for calling NSLocalizedString method.
    func localized() -> String {
        NSLocalizedString(self, comment: "")
    }

    /// Calculate MD5 hash from a given String
    func MD5Hash() -> String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}

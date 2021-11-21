//
//  UITableView+Ext.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

extension UITableView {

    func setTableHeaderView(headerView: UIView?) {
        headerView?.translatesAutoresizingMaskIntoConstraints = false
        
        // set the headerView
        tableHeaderView = headerView

        // check if the passed view is nil
        guard let headerView = headerView else { return }

        // check if the tableHeaderView superview view is nil just to avoid
        // to use the force unwrapping later. In case it fail something really
        // wrong happened
        guard let tableHeaderViewSuperview = tableHeaderView?.superview else {
            assertionFailure("This should not be reached!")
            return
        }

        // force updated layout
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()

        // set tableHeaderView width
        tableHeaderViewSuperview.addConstraint(
            headerView.widthAnchor.constraint(
                equalTo: tableHeaderViewSuperview.widthAnchor,
                multiplier: 1.0
            )
        )

        // set tableHeaderView height
        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        tableHeaderViewSuperview.addConstraint(
            headerView.heightAnchor.constraint(
                equalToConstant: height
            )
        )
    }
}

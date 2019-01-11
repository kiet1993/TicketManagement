//
//  UIViewController+ContainerView.swift
//  AkiTravel
//
//  Created by Phu Nguyen on 11/22/18.
//  Copyright © 2018 Aki Travel. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
    
    func addViewController(_ viewController: UIViewController?, toContainerView containerView: UIView) {
        if let viewController = viewController {
            viewController.willMove(toParent: self)

            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(viewController.view)

            NSLayoutConstraint.activate([
                NSLayoutConstraint(item: viewController.view, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: viewController.view, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: viewController.view, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: viewController.view, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0)
                ])

            addChild(viewController)
            viewController.didMove(toParent: self)
        }
    }

    func removeFromContainerView() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
        didMove(toParent: nil)
    }
}

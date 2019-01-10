//
//  BasePlanCollectionViewCell.swift
//  AkiTravel
//
//  Created by macintosh on 12/11/18.
//  Copyright © 2018 Aki Travel. All rights reserved.
//

import UIKit

class PlanCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet private weak var positionXCT: NSLayoutConstraint! // 67 if not opened.
    private let dX: CGFloat = 64
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}

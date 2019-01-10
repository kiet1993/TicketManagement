//
//  PageCollectionView.swift
//  TestCollectionView
//
//  Created by Alex K. on 05/05/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

class PageCollectionView: UICollectionView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
}

// MARK: init

extension PageCollectionView {

    class func createOnView(_ view: UIView,
                            layout: UICollectionViewLayout,
                            height: CGFloat,
                            inforView: UIView,
                            dataSource: UICollectionViewDataSource,
                            delegate: UICollectionViewDelegate) -> PageCollectionView {

        let collectionView = Init(PageCollectionView(frame: CGRect.zero, collectionViewLayout: layout)) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.decelerationRate = UIScrollView.DecelerationRate.fast
            $0.showsHorizontalScrollIndicator = false
            $0.dataSource = dataSource
            $0.delegate = delegate
            $0.backgroundColor = UIColor(white: 0, alpha: 0)
        }
        view.addSubview(collectionView)
        collectionView.heightAnchor.constraint(equalToConstant: height).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: inforView.topAnchor, constant: -40).isActive = true
        return collectionView
    }
}

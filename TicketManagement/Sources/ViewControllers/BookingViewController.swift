//
//  BookingViewController.swift
//  AkiTravel
//
//  Created by Phu Nguyen on 12/4/18.
//  Copyright © 2018 Aki Travel. All rights reserved.
//

import UIKit

struct Film {
    var content: String
    var title: String
}

protocol BookingViewControllerDelegate: class {
    func didBookTicket(for film: Film, ticketId: UUID)
}

class BookingViewController: UIViewController {
    /// The default size to use for cells. Height of open cell state
    var itemSize = CGSize(width: 236, height: 392.5)
    ///  The collection view object managed by this view controller.
    fileprivate var collectionView: PageCollectionView!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var inforView: UIView!
    weak var delegate: BookingViewControllerDelegate?
    
    /// Index of current cell
    private var previousIndex = 0
    var currentIndex: Int {
        guard let collectionView = self.collectionView else { return 0 }
        
        let startOffset = (collectionView.bounds.size.width - itemSize.width) / 2
        guard let collectionLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return 0
        }
        let minimumLineSpacing = collectionLayout.minimumLineSpacing
        let a = collectionView.contentOffset.x + startOffset + itemSize.width / 2
        let b = itemSize.width + minimumLineSpacing
        let index = Int(a / b)
        return index
    }
    
    var items = [Film]()
    
    // MARK: Overrrides
    override func viewDidLoad() {
        super.viewDidLoad()
        createDummyData()
        setupCollectionView()
        setupInforView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


// MARK: Setup

extension BookingViewController {
    fileprivate func createDummyData() {
        let film0 = Film(content: "", title: "Mary Poppings returns")
        let film1 = Film(content: "", title: "MY assistant")
        let film2 = Film(content: "", title: "Bummble Bee")
        let film3 = Film(content: "", title: "Snow girl")
        let film4 = Film(content: "", title: "Dead room")
        let film5 = Film(content: "", title: "Dark Figure Of Crimem")
        let film6 = Film(content: "", title: "Bear gangsta")
        let film7 = Film(content: "", title: "Mafia town - returns")
        let film8 = Film(content: "", title: "See or die, dead photo")
        let film9 = Film(content: "", title: "Spiderman - into spider-verse")
        let film10 = Film(content: "", title: "No home")
        let film11 = Film(content: "", title: "Aquaman")
        items.append(contentsOf: [film0, film1, film2, film3, film4, film5, film6, film7, film8, film9, film10, film11])
    }
    
    fileprivate func setupCollectionView() {
        
        let layout = PageCollectionLayout(itemSize: itemSize)
        collectionView = PageCollectionView.createOnView(view,
                                                         layout: layout,
                                                         height: 392.5,
                                                         inforView: inforView,
                                                         dataSource: self,
                                                         delegate: self)
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = false
        if #available(iOS 10.0, *) {
            collectionView?.isPrefetchingEnabled = false
        }
        registerCell()
    }
    
    private func setupInforView() {
        updateInforView()
    }
    
    @IBAction private func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func book() {
        dismiss(animated: true) { [unowned self] in
            self.delegate?.didBookTicket(for: self.items[self.currentIndex], ticketId: UUID())
        }
    }
}

// MARK: Privates and Helpers
extension BookingViewController {
    
    fileprivate func registerCell() {
        let nib = UINib(nibName: "PlanCollectionViewCell", bundle: Bundle(for: BookingViewController.self))
        collectionView?.register(nib, forCellWithReuseIdentifier: "Cell")
    }
    
    fileprivate func updateInforView() {
        guard currentIndex < items.count else { return }
        let item = items[currentIndex]
        titleLabel.text = item.title
        descriptionLabel.text = item.content
    }
    
    private func animateInforView(isFromRightToLeft: Bool) {
        UIView.animate(withDuration: 0.2, animations: { [unowned self] in
            for view in self.inforView.subviews where view != self.bookButton.superview! {
                view.alpha = 0.0
            }
        }) { [unowned self] (_) in
            self.updateInforView()
            for view in self.inforView.subviews where view != self.bookButton.superview! {
                view.transform = CGAffineTransform(translationX: isFromRightToLeft ? 15 : -15, y: 0)
            }
            UIView.animate(withDuration: 0.3, animations: {
                for view in self.inforView.subviews where view != self.bookButton {
                    guard self.currentIndex < self.items.count else { continue }
                    view.alpha = 1
                    view.transform = CGAffineTransform(translationX: 0, y: 0)
                }
            })
        }
    }
}

// MARK: UIScrollDelegate
extension BookingViewController {
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if self.previousIndex == self.currentIndex { return }
            self.animateInforView(isFromRightToLeft: self.previousIndex < self.currentIndex)
            self.previousIndex = self.currentIndex
        }
    }
}

// MARK: UICollectionViewDelegate
extension BookingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PlanCollectionViewCell {
            cell.imageView.image = UIImage(named: "phim\(indexPath.row + 1)")
            return cell
        }
        return UICollectionViewCell()
    }
}

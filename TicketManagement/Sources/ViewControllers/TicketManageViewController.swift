//
//  TicketManageViewController.swift
//  TicketManagement
//
//  Created by Phu Nguyen on 1/7/19.
//  Copyright © 2019 Nals. All rights reserved.
//

import UIKit

class TicketManageViewController: UIViewController {
    
    var delegate: TicketManageDelegate?
    
    var contentViewController: UIViewController? {
        willSet {
            contentViewController?.removeFromContainerView()
        }
        
        didSet {
            addViewController(contentViewController, toContainerView: view)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
    }
}

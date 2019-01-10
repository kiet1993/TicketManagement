//
//  TicketManager.swift
//  TicketManagement
//
//  Created by Phu Nguyen on 1/8/19.
//  Copyright © 2019 Nals. All rights reserved.
//

import Foundation
import UIKit

public enum TicketStatus {
    case success(String)
    case failed(String)
}

public protocol TicketManageDelegate {
    func canceled()
    func finish(with status: TicketStatus)
}

public class TicketManager {
    
    var delegate: TicketManageDelegate?
    var presentViewController: UIViewController?
    var isAuthenticated = false
    
    public init(viewcontroller: UIViewController) {
        self.presentViewController = viewcontroller
        self.delegate = viewcontroller as? TicketManageDelegate
    }
    
    open func openBookingTicketViewController() {
        print("openBookingTicketViewController")
        if isAuthenticated {
            showBookTicketView()
        } else {
            showLoginView()
        }
    }
    
    private func showLoginView() {
        print("showLoginView")
        let sb = UIStoryboard (name: StoryboardName.Login, bundle: Bundle(for: LoginViewController.self))
        let vc = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.delegate = self
        self.presentViewController?.present(vc, animated: true, completion: nil)
    }
    
    private func showBookTicketView() {
        print("showBookTicketView")
        let sb = UIStoryboard (name: StoryboardName.Booking, bundle: Bundle(for: BookingViewController.self))
        let vc = sb.instantiateViewController(withIdentifier: "BookingViewController") as! BookingViewController
        vc.delegate = self
        self.presentViewController?.present(vc, animated: true, completion: nil)
    }
}

extension TicketManager: LoginViewControllerDelegate {
    public func canceled() {
        delegate?.canceled()
    }
    
    public func loginSuccess(with userId: String) {
        isAuthenticated = true
        showBookTicketView()
    }
}

extension TicketManager: BookingViewControllerDelegate {
    func didBookTicket(for film: Film, ticketId: UUID) {
        delegate?.finish(with: .success(ticketId.uuidString))
    }
}

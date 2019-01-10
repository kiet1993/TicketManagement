//
//  TicketManager.swift
//  TicketManagement
//
//  Created by Phu Nguyen on 1/8/19.
//  Copyright © 2019 Nals. All rights reserved.
//

import Foundation
import UIKit


/// Enum that defines status of ticket.
///
/// - success: success status.
/// - failed: failed status.
public enum TicketStatus {
    /// - success: successfully status, with success message.
    case success(String)
    
    /// - failed: failed status, with error message.
    case failed(String)
}


/// The delegate returns result of SDK actions.
public protocol TicketManageDelegate {
    /// Return when Ticket booking has been cancelled.
    func canceled()
    
    
    /// Return when Ticket booking has been booked successfully, includes status.
    ///
    /// - Parameter status: status of ticket.
    func finish(with status: TicketStatus)
}


/// class that manages Ticket Booking flows.
public class TicketManager {
    
    var delegate: TicketManageDelegate?
    var presentViewController: UIViewController?
    var isAuthenticated = false
    
    
    /// Init TicketManager with paired viewController, this controller will present TicketManager screens.
    ///
    /// - Parameter viewcontroller: paired viewController.
    public init(viewController: UIViewController) {
        self.presentViewController = viewController
        self.delegate = viewController as? TicketManageDelegate
    }
    
    /// Open Ticket Management Flow, if user is not logged in before, the SDK will show login screen, otherwise open booking ticket screen.
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
    func canceled() {
        delegate?.canceled()
    }

    func loginSuccess(with userId: String) {
        isAuthenticated = true
        showBookTicketView()
    }
}

extension TicketManager: BookingViewControllerDelegate {
    func didBookTicket(for film: Film, ticketId: UUID) {
        delegate?.finish(with: .success(ticketId.uuidString))
    }
}

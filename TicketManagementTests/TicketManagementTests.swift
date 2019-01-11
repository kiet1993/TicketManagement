//
//  TicketManagementTests.swift
//  TicketManagementTests
//
//  Created by Phu Nguyen on 1/7/19.
//  Copyright © 2019 Nals. All rights reserved.
//

import XCTest
@testable import TicketManagement

class TicketManagementTests: XCTestCase {
    
    var viewController: UIViewController?
    var ticketManager: TicketManager?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewController = UIViewController()
        if let vc = viewController {
            ticketManager = TicketManager(viewController: vc)
        }
    }

    override func tearDown() {
        ticketManager = nil
    }

    func testInitClass() {
        XCTAssertNotNil(ticketManager, "ticketManager is nil")
    }
    
    func testShowLoginView() {
        ticketManager?.openBookingTicketViewController()
        XCTAssertNoThrow(ticketManager?.showLoginView(), "Should so login view")
    }
    
    func testShowBookingView() {
        ticketManager?.isAuthenticated = true
        XCTAssertNoThrow(ticketManager?.showBookTicketView(), "Should so ticket view")
    }
}

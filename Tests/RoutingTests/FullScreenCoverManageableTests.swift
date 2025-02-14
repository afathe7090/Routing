//
//  FullScreenCoverManageableTests.swift
//  
//
//  Created by James Sedlacek on 12/16/23.
//

import XCTest
import SwiftUI
@testable import Routing

final class FullScreenCoverManageableTests: XCTestCase {
    private var router: MockFullScreenCoverManager!

    override func setUp() {
        super.setUp()
        router = .init()
    }

    override func tearDown() {
        router = nil
        super.tearDown()
    }

    func testPresentSheet() {
        router.presentFullScreenCover(.settings)
        XCTAssertNotNil(router.fullScreenCover)
    }

    func testDismissSheet() {
        router.presentFullScreenCover(.settings)
        router.dismissFullScreenCover()
        XCTAssertNil(router.fullScreenCover)
    }
    
    func testPresentOnDismissingAction() {
        
        router.presentFullScreenCover(.settings, onDismiss: { })
        XCTAssertNotNil(router.onDismiss)

        router.presentFullScreenCover(.settings)
        XCTAssertNil(router.onDismiss)

    }
}

fileprivate class MockFullScreenCoverManager: FullScreenCoverManageable {
    typealias Destination = Route
    
    var onDismiss: Dismissable.DismissAction?
    @Published var fullScreenCover: Route?

    enum Route: ViewDisplayable {
        case settings

        @ViewBuilder
        var viewToDisplay: some View {
            switch self {
            case .settings:
                MockSettingsView()
            }
        }
    }
}

fileprivate struct MockSettingsView: View {
    var body: some View {
        Text("Mock Settings View")
    }
}

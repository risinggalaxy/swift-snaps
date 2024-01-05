//
//  AppTest.swift
//  SwiftSnapsTests
//
//  Created by Yasser Farahi on 04/01/2024.
//

import XCTest
import ComposableArchitecture
@testable import SwiftSnaps

@MainActor
final class AppTest: XCTestCase {
    func testVendorPagePushedIntoStack() async {
        let mock = VendorsResponse.mock
        let store = TestStore(initialState: AppFeature.State(vendorList: VendorsListFeature.State(vendors: mock))) {
            AppFeature()
        }
        let vendor: Vendor = .mock
        await store.send(.path(.push(id: 0, state: .vendorPage(VendorPageFeature.State(vendorID: vendor.id))))) { state in
            state.path[id: 0] = .vendorPage(VendorPageFeature.State(vendorID: vendor.id))
        }
    }
}

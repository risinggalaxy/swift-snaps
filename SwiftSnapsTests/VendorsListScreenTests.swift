//
//  VendorsListScreenTests.swift
//  SwiftSnapsTests
//
//  Created by Yasser Farahi on 04/01/2024.
//

import XCTest
@testable import SwiftSnaps
import ComposableArchitecture

@MainActor
final class VendorsListScreenTests: XCTestCase {
    
    func testAVendorWasTapped() async {
        let store = TestStore(initialState: VendorsListFeature.State()) {
            VendorsListFeature()
        }
        
        let vendor: Vendor = .mock
        await store.send(.aVendorWasSelected(vendor)) { state in
            state.showVendorPage = VendorPageFeature.State(vendorID: vendor.id)
        }
    }
}

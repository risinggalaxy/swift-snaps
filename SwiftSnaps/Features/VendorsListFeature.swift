//
//  VendorsListFeature.swift
//  SwiftSnaps
//
//  Created by Yasser Farahi on 04/01/2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct VendorsListFeature {
    struct State: Equatable {
        @PresentationState var showVendorPage: VendorPageFeature.State?
        var viewIsLoading: Bool = false
        var vendors: IdentifiedArrayOf<Vendor> = []
    }
    
    enum Action: Equatable {
        
        static func == (lhs: VendorsListFeature.Action, rhs: VendorsListFeature.Action) -> Bool {
            true
        }
        
        case loadVendors
        case updateVendorsList(Any)
        case aVendorWasSelected(Vendor)
        case showVendorPage(PresentationAction<VendorPageFeature.Action>)
    }
    
    @Dependency(\.vendorsClient) var vendorsList
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadVendors:
                state.viewIsLoading = true
                return .run { send in
                    try await send(.updateVendorsList(self.vendorsList.fetch(URI.endPoint, .vendorList)))
                }
            case let .updateVendorsList(response):
                if let vendorResponse = response as? VendorsResponse {
                    let vendors = IdentifiedArrayOf(uniqueElements: vendorResponse.vendors)
                    state.viewIsLoading = false
                    state.vendors = vendors
                }
                return .none
            case let .aVendorWasSelected(vendor):
                state.showVendorPage = VendorPageFeature.State(vendorID: vendor.id)
                return .none
                
            case .showVendorPage:
                return .none
            }
        }
        .ifLet(\.$showVendorPage,
                action: /Action.showVendorPage) {
            VendorPageFeature()
        }
    }
}

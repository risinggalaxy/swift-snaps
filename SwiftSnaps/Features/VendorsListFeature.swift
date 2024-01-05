//
//  VendorsListFeature.swift
//  SwiftSnaps
//
//  Created by Yasser Farahi on 04/01/2024.
//

import Foundation
import ComposableArchitecture

struct VendorsListClient {
    var fetch: @Sendable () async throws -> IdentifiedArrayOf<Vendor>
}

extension VendorsListClient: DependencyKey {
    static let liveValue = Self {
        do {
            if let url = URL(string: URI.endPoint) {
                let (data, _) = try await URLSession.shared.data(from: url)
                let vendorsResponse = try JSONDecoder().decode(VendorsResponse.self, from: data)
                let vendors = IdentifiedArrayOf(uniqueElements: vendorsResponse.vendors)
                return vendors
            } else {
                fatalError()
            }
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
}

extension DependencyValues {
    var vendorsList: VendorsListClient {
        get { self[VendorsListClient.self] }
        set { self[VendorsListClient.self] = newValue }
    }
}

@Reducer
struct VendorsListFeature {
    struct State: Equatable {
        @PresentationState var showVendorPage: VendorPageFeature.State?
        var viewIsLoading: Bool = false
        var vendors: IdentifiedArrayOf<Vendor> = []
    }
    
    enum Action: Equatable {
        case loadVendors
        case updateVendorsList(IdentifiedArrayOf<Vendor>)
        case aVendorWasSelected(Vendor)
        case showVendorPage(PresentationAction<VendorPageFeature.Action>)
    }
    
    @Dependency(\.vendorsList) var vendorsList
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadVendors:
                state.viewIsLoading = true
                return .run { send in
                    try await send(.updateVendorsList(self.vendorsList.fetch()))
                }
            case let .updateVendorsList(vendors):
                state.viewIsLoading = false
                state.vendors = vendors
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

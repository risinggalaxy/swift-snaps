//
//  VendorsListScreen.swift
//  SwiftSnaps
//
//  Created by Yasser Farahi on 04/01/2024.
//

import SwiftUI
import ComposableArchitecture

struct VendorsListScreen: View {
    internal let store: StoreOf<VendorsListFeature>
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            if !viewStore.viewIsLoading {
                List {
                    ForEach(viewStore.state.vendors) { vendor in
                        NavigationLink(state: AppFeature.Path.State.vendorPage(VendorPageFeature.State(vendorID: vendor.id))) {
                            VendorsListCell(vendor: vendor)
                        }
                    }
                }.onAppear(perform: {
                    if viewStore.state.vendors.isEmpty {
                        viewStore.send(.loadVendors)
                    }
                })
            } else {
                ProgressView("Loading...")
            }
        }
    }
}

#Preview {
    VendorsListScreen(store: Store(initialState: VendorsListFeature.State(vendors: VendorsResponse.mock), reducer: {
        VendorsListFeature()
            ._printChanges()
    }))
}

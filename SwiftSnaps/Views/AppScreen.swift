//
//  AppScreen.swift
//  SwiftSnaps
//
//  Created by Yasser Farahi on 04/01/2024.
//

import ComposableArchitecture
import SwiftUI
struct AppScreen: View {
    let store: StoreOf<AppFeature>
    var body: some View {
        NavigationStackStore(store.scope(state: \.path, action: { .path($0) })) {
            VendorsListScreen(store: store.scope(state: \.vendorList, action: { .vendorList($0) }))
        } destination: { state in
            switch state {
            case .vendorList:
                CaseLet(
                    /AppFeature.Path.State.vendorList,
                    action: AppFeature.Path.Action.vendorList) { store in
                    VendorsListScreen(store: store)
                }
            case .vendorPage:
                CaseLet(/AppFeature.Path.State.vendorPage,
                    action: AppFeature.Path.Action.vendorPage) { store in
                    VendorPage(store: store)
                }
            }
        }
    }
}

#Preview {
    AppScreen(store: Store(initialState: AppFeature.State(vendorList: VendorsListFeature.State(vendors: VendorsResponse.mock)),
    reducer: {
        AppFeature()
    }))
}

//
//  VendorPage.swift
//  SwiftSnaps
//
//  Created by Yasser Farahi on 04/01/2024.
//

import SwiftUI
import ComposableArchitecture

struct VendorPage: View {
    internal let store: StoreOf<VendorPageFeature>
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            if !viewStore.viewIsLoading {
                List {
                    ForEach(viewStore.state.articles, id: \.url) { article in
                        ArticleCell(article: article)
                    }
                }.onAppear(perform: {
                    if viewStore.state.articles.isEmpty {
                        viewStore.send(.loadData)
                    }
                })
            } else {
                ProgressView("Loading...")
            }
        }
    }
}

#Preview {
    VendorPage(store: Store(initialState: VendorPageFeature.State(), reducer: {
        VendorPageFeature()
    }))
}

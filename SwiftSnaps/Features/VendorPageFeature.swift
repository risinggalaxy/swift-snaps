//
//  VendorPageFeature.swift
//  SwiftSnaps
//
//  Created by Yasser Farahi on 04/01/2024.
//

import ComposableArchitecture
import Foundation

@Reducer
struct VendorPageFeature {
    
    struct State: Equatable {
        var vendorID: String = .init()
        var articles: [Article] = []
        var viewIsLoading: Bool = false
    }
    
    enum Action: Equatable {
        
        static func == (lhs: VendorPageFeature.Action, rhs: VendorPageFeature.Action) -> Bool {
            true
        }
        
        case loadData
        case fetchArticles(Any)
    }
    
    @Dependency(\.vendorsClient) var vendorArticles
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadData:
                state.viewIsLoading = true
                return .run { [vendorID = state.vendorID] send in
                    try await send(.fetchArticles(self.vendorArticles.fetch(URI.getHeadlines(by: vendorID), .vendorPage)))
                }
            case let .fetchArticles(response):
                if let response = response as? VendorArticleResponse {
                    state.viewIsLoading = false
                    let articles = response.articles
                    state.articles = articles
                }
                return .none
            }
        }
    }
}

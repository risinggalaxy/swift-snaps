//
//  VendorPageFeature.swift
//  SwiftSnaps
//
//  Created by Yasser Farahi on 04/01/2024.
//

import ComposableArchitecture
import Foundation

struct VendorArticleResponse: Decodable, Equatable {
    let articles: [Article]
}

struct Article: Decodable, Equatable {
    let author: String?
    let title: String
    let description: String?
    let url: String?
    let content: String?
    let publishedAt: String
    let urlToImage: String?
}

extension Article {
    static let mock = Self(author: "Yasser Farahi",
                           title: "Swift Composable Architecture",
                           description: "A Quick demo of the Swift Composable Architecture",
                           url: nil,
                           content: nil,
                           publishedAt: "January 4th 2024",
                           urlToImage: nil)
}

struct VendorPageClient {
    var fetch: @Sendable (String) async throws -> [Article]
}

extension VendorPageClient: DependencyKey {
    static let liveValue = Self { vendorID in
        do {
            if let url = URI.getHeadlines(by: vendorID) {
                let (data, _) = try await URLSession.shared.data(from: url)
                let articles = try JSONDecoder().decode(VendorArticleResponse.self, from: data)
                return articles.articles
            } else {
                fatalError()
            }
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
}

extension DependencyValues {
    var vendorArticles: VendorPageClient {
        get { self[VendorPageClient.self] }
        set { self[VendorPageClient.self] = newValue }
    }
}

@Reducer
struct VendorPageFeature {
    struct State: Equatable {
        var vendorID: String = .init()
        var articles: [Article] = []
        var viewIsLoading: Bool = false
    }
    
    enum Action: Equatable {
        case loadData
        case fetchArticles([Article])
    }
    
    @Dependency(\.vendorArticles) var vendorArticles
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadData:
                state.viewIsLoading = true
                return .run { [vendorID = state.vendorID] send in
                    try await send(.fetchArticles(self.vendorArticles.fetch(vendorID)))
                }
            case let .fetchArticles(articles):
                state.viewIsLoading = false
                state.articles = articles
                return .none
            }
        }
    }
}

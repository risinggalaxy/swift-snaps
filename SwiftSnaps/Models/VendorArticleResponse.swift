//
//  VendorArticleResponse.swift
//  SwiftSnaps
//
//  Created by Yasser Farahi on 05/01/2024.
//

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

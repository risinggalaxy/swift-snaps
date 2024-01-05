//
//  Vendor.swift
//  SwiftSnaps
//
//  Created by Yasser Farahi on 04/01/2024.
//

import Foundation

struct Vendor: Codable, Equatable, Identifiable {
    let id: String
    let name: String
    let description: String
}

extension Vendor {
    static let mock: Self = Self(id: "abc-news",
        name: "ABC News",
        description: "Your trusted source for breaking news, analysis, exclusive interviews, headlines, and videos at ABCNews.com.")
}

//
//  URI.swift
//  SwiftSnaps
//
//  Created by Yasser Farahi on 04/01/2024.
//

import Foundation
enum URI {
    private static let uri: String = "https://newsapi.org/v2/sources"
    private static let apiKey: String = "1048c77a0acb47758ae98aa1d4d95fd9"
    static let endPoint: String = uri + "?apiKey=" + apiKey
    static func getHeadlines(by vendorId: String) -> URL? {
        return URL(string: "https://newsapi.org/v2/top-headlines?sources=\(vendorId)&apiKey=\(apiKey)")
    }
}

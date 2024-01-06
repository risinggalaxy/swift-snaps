//
//  VendorClientDependency.swift
//  SwiftSnaps
//
//  Created by Yasser Farahi on 06/01/2024.
//

import Foundation
import ComposableArchitecture

struct VendorsClient {
    var fetch: @Sendable (String, ResponseType) async throws -> Any
    
    internal enum ResponseType {
        case vendorList
        case vendorPage
    }
    
    static private func responseProvider(for type: ResponseType) -> Decodable.Type {
        switch type {
        case .vendorList: return VendorsResponse.self
        case .vendorPage: return VendorArticleResponse.self
        }
    }
    
}

extension VendorsClient: DependencyKey {
    static let liveValue = Self { uri, type  in
        do {
            if let url = URL(string: uri) {
                let (data, _) = try await URLSession.shared.data(from: url)
                let response = try JSONDecoder().decode(responseProvider(for: type), from: data)
                return response
            } else {
                fatalError()
            }
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
}

extension DependencyValues {
    var vendorsClient: VendorsClient {
        get { self[VendorsClient.self] }
        set { self[VendorsClient.self] = newValue }
    }
}

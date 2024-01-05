//
//  AppFeature.swift
//  SwiftSnaps
//
//  Created by Yasser Farahi on 04/01/2024.
//

import ComposableArchitecture
import Foundation

@Reducer
struct AppFeature {
    struct State: Equatable {
        var path = StackState<Path.State>()
        var vendorList = VendorsListFeature.State()
        var vendorPage = VendorPageFeature.State()
    }
    
    enum Action: Equatable {
        case path(StackAction<Path.State, Path.Action>)
        case vendorList(VendorsListFeature.Action)
        case vendorPage(VendorPageFeature.Action)
    }
    
    @Reducer
    struct Path {
        enum State: Equatable {
            case vendorList(VendorsListFeature.State)
            case vendorPage(VendorPageFeature.State)
        }
        
        @CasePathable
        enum Action: Equatable {
            case vendorList(VendorsListFeature.Action)
            case vendorPage(VendorPageFeature.Action)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: /State.vendorList,
                action: /Action.vendorList) {
                VendorsListFeature()
            }
            
            Scope(state: /State.vendorPage,
                action: /Action.vendorPage) {
                VendorPageFeature()
            }
        }
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.vendorList,
        action: /Action.vendorList)
        { VendorsListFeature() }
        
        Reduce { state, action in
            switch action {
            case .vendorList:
                return .none
            case .vendorPage:
                return .none
            case .path:
                return .none
                
            }
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}


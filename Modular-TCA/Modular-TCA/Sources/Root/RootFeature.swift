//
//  RootFeature.swift
//  Modular-TCA
//
//  Created by Wimes on 2022/11/19.
//

import Foundation
import ComposableArchitecture

struct RootFeature: ReducerProtocol {
    enum State: Equatable {
        case login(LoginFeature.State)
        case tabBar(TabBarFeature.State)
        
        init() { self = .login(LoginFeature.State()) }
    }
    
    enum Action {
        case login(LoginFeature.Action)
        case tabBar(TabBarFeature.Action)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case let .login(.loggedIn(loginData)):
                state = .tabBar(.init(loginData: loginData))
                return .none
            case .tabBar:
                return .none
            }
        }
    }
}

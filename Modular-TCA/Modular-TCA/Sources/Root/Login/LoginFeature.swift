//
//  LoginFeature.swift
//  Modular-TCA
//
//  Created by Wimes on 2022/11/19.
//

import Foundation
import ComposableArchitecture

struct LoginFeature: ReducerProtocol {
    struct State: Equatable { }
    enum Action {
        case loggedIn(loginData: String)
    }
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            return .none
        }
    }
}

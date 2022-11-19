//
//  TabBarFeature.swift
//  Modular-TCA
//
//  Created by Wimes on 2022/11/19.
//

import Foundation
import ComposableArchitecture
import A
import B1

struct TabBarFeature: ReducerProtocol {
    struct State: Equatable {
        var a1: A1Feature.State = .init()
        var b1: B1Feature.State
        
        init(loginData: String) {
            self.b1 = .init(loginData: loginData)
        }
    }
    enum Action {
        case a1(A1Feature.Action)
        case b1(B1Feature.Action)
    }
    var body: some ReducerProtocol<State, Action> {
        Scope(state: \.a1, action: /Action.a1) {
            A1Feature()
        }
        Scope(state: \.b1, action: /Action.b1) {
            B1Feature()
        }
    }
}

// MARK: (note) 아래처럼 extension으로 쓸 경우 타입추론이 안된다. body 부분에서 \.으로 타입추론중인데 여기서 에러
//extension TabBarFeature {
//    struct State: Equatable {
//        var a1: A1Feature.State = .init()
//        var b1: B1Feature.State
//
//        init(loginData: String) {
//            self.b1 = .init(loginData: loginData)
//        }
//    }
//}
//
//extension TabBarFeature {
//    enum Action {
//        case a1(A1Feature.Action)
//        case b1(B1Feature.Action)
//    }
//}
//
//extension TabBarFeature {
//    var body: some ReducerProtocol<State, Action> {
//        Scope(state: \.a1, action: /Action.a1) {
//            A1Feature()
//        }
//        Scope(state: \.b1, action: /Action.b1) {
//            B1Feature()
//        }
//    }
//}

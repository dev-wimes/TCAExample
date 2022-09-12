//
//  TabBarInteractor.swift
//  Modular-TCA
//
//  Created by Wimes on 2022/01/08.
//

import ComposableArchitecture
import Effects
import A
import B1


struct TabBarState: Equatable {
    var loginData: String
    
    var a = ACoordinatorState()
    var b = BCoordinatorState()
}

enum TabBarAction {
    case a(ACoordinatorAction)
    case b(BCoordinatorAction)
}

struct TabBarEnvironmnet { }

let tabBarReducer: Reducer<
    TabBarState,
    TabBarAction,
    TabBarEnvironmnet
> = .combine(
    aCoordinatorReducer
        .pullback(
            state: \.a,
            action: /TabBarAction.a,
            environment: { _ in .init() }
        ),
    bCoordinatorReducer
        .pullback(
            state: \.b,
            action: /TabBarAction.b,
            environment: { _ in .init() }
        )
)

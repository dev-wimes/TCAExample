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
    var b1State = B1State()
}

enum TabBarAction {
    case a(ACoordinatorAction)
    case b1Action(B1Action)
}

struct TabBarEnvironmnet { }

let tabBarReducer: Reducer<
    TabBarState,
    TabBarAction,
    TabBarEnvironmnet
> = .combine(
    aCoordinatorReducer
        .pullback(
            state: \TabBarState.a,
            action: /TabBarAction.a,
            environment: { _ in .init() }
        ),
    b1Reducer
        .pullback(
            state: \.b1State,
            action: /TabBarAction.b1Action,
            environment: { _ in .init(
                request: { EffectsImpl().numbersApiTwo() },
                mainQueue: { .main }
            )}
        )
)

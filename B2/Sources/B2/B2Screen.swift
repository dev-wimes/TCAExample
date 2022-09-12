//
//  File.swift
//
//
//  Created by Wimes on 2022/09/07.
//

import ComposableArchitecture
import Effects

public enum B2ScreenState: Equatable {
    case b2(B2State)
}

public enum B2ScreenAction {
    case b2(B2Action)
}

public struct B2ScreenEnvironment { }

public let b2ScreenReducer = Reducer<
    B2ScreenState,
    B2ScreenAction,
    B2ScreenEnvironment
>.combine([
    b2Reducer.pullback(
        state: /B2ScreenState.b2,
        action: /B2ScreenAction.b2,
        environment: { _ in B2Environment(
            request: { EffectsImpl().numbersApiFour() },
            mainQueue: { .main }
        ) }
    )
])

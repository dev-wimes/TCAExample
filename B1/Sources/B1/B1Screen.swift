//
//  File.swift
//
//
//  Created by Wimes on 2022/09/07.
//

import ComposableArchitecture
import Effects

public enum B1ScreenState: Equatable {
    case b1(B1State)
}

public enum B1ScreenAction {
    case b1(B1Action)
}

public struct B1ScreenEnvironment { }

public let b1ScreenReducer = Reducer<
    B1ScreenState,
    B1ScreenAction,
    B1ScreenEnvironment
>.combine([
    b1Reducer.pullback(
        state: /B1ScreenState.b1,
        action: /B1ScreenAction.b1,
        environment: { _ in .init(
            request: { EffectsImpl().numbersApiTwo() },
            mainQueue: { .main }
        ) }
    )
])

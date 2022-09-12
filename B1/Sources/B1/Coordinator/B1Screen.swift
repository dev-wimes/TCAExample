//
//  File.swift
//
//
//  Created by Wimes on 2022/09/07.
//

import ComposableArchitecture
import Effects

public enum BScreenState: Equatable {
    case b1(B1State)
}

public enum BScreenAction {
    case b1(B1Action)
}

public struct BScreenEnvironment { }

public let bScreenReducer = Reducer<
    BScreenState,
    BScreenAction,
    BScreenEnvironment
>.combine([
    b1Reducer.pullback(
        state: /BScreenState.b1,
        action: /BScreenAction.b1,
        environment: { _ in .init(
            request: { EffectsImpl().numbersApiTwo() },
            mainQueue: { .main }
        ) }
    )
])

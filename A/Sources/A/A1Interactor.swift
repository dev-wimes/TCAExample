//
//  A1Interactor.swift
//  
//
//  Created by Wimes on 2022/01/12.
//

import Foundation
import Effects
import ComposableArchitecture

public struct A1State: Equatable {
    var resultString: String
    
    public init(resultString: String = "...") {
        self.resultString = resultString
    }
}

public enum A1Action: Equatable {
    case onAppear
    case dataLoaded(Result<String, ApiError>)
    case didTapButton
}

public struct A1Environment {
    
    public init() { }
    
    var request: () -> Effect<String, ApiError> = {
        let effects: Effects = EffectsImpl()
        return effects.numbersApiOne()
    }
    
    var mainQueue: () -> AnySchedulerOf<DispatchQueue> = {
        .main
    }
}

public let a1Reducer = Reducer<
    A1State,
    A1Action,
    A1Environment
> { state, action, environment in
    switch action {
    case .onAppear:
        state.resultString = "..."
        return environment.request()
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(A1Action.dataLoaded)
    case .dataLoaded(let result):
        switch result {
        case .success(let result):
            state.resultString = result
        case .failure(let error):
            break
        }
        return .none
    case .didTapButton:
        return .none
    }
}

func dummyA1Effect() -> Effect<String, ApiError> {
    let dummyString = "test"
    return Effect(value: dummyString)
}


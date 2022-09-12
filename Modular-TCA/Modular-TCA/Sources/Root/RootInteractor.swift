//
//  RootInteractor.swift
//  Modular-TCA
//
//  Created by Wimes on 2022/01/08.
//

import ComposableArchitecture

enum RootState: Equatable {
    case login(LoginState)
    case tabBar(TabBarState)
    
    public init() { self = .login(.init()) }
}


enum RootAction {
    case loginAction(LoginAction)
    case tabBarAction(TabBarAction)
}

struct RootEnvironment { }

let rootReducer: Reducer<
    RootState,
    RootAction,
    RootEnvironment
> = Reducer { _, _, _ in
    return .none
}

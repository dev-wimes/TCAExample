//
//  RootScreen.swift
//  Modular-TCA
//
//  Created by Wimes on 2022/09/12.
//

import ComposableArchitecture

enum RootScreenState: Equatable {
    case login(LoginState)
    case tabBar(TabBarState)
}

enum RootScreenAction {
    case login(LoginAction)
    case tabBar(TabBarAction)
}

struct RootScreenEnvironment { }

let rootScreenReducer = Reducer<
    RootScreenState,
    RootScreenAction,
    RootScreenEnvironment
>.combine([
    loginReducer.pullback(
        state: /RootScreenState.login,
        action: /RootScreenAction.login,
        environment: { _ in LoginEnvironmnet() }
    ),
    tabBarReducer.pullback(
        state: /RootScreenState.tabBar,
        action: /RootScreenAction.tabBar,
        environment: { _ in TabBarEnvironmnet() }
    )
])

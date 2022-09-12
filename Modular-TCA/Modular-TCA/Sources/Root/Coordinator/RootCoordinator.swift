//
//  RootCoordinator.swift
//  Modular-TCA
//
//  Created by Wimes on 2022/09/12.
//

import ComposableArchitecture
import TCACoordinators

struct RootCoordinatorState: Equatable, IndexedRouterState {
    var routes: [Route<RootScreenState>]
    
    init(routes: [Route<RootScreenState>] = [.root(.login(.init()))]) {
        self.routes = routes
    }
}

enum RootCoordinatorAction: IndexedRouterAction {
    case routeAction(Int, action: RootScreenAction)
    case updateRoutes([Route<RootScreenState>])
}

struct RootCoordinatorEnvironment { }

let rootCoordinatorReducer: Reducer<
    RootCoordinatorState,
    RootCoordinatorAction,
    RootCoordinatorEnvironment
> = rootScreenReducer
    .forEachIndexedRoute(environment: { _ in RootScreenEnvironment() })
    .withRouteReducer(
        Reducer { state, action, environment in
            switch action {
            case .routeAction(_, action: .login(.loggedIn(let loginData))):
                state.routes.presentCover(.tabBar(.init(loginData: loginData)), embedInNavigationView: true)
                return .none
            case .routeAction(_, action: .tabBar(_)):
                return .none
            case .updateRoutes(_):
                return .none
            }
        }
    )

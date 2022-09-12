//
//  File.swift
//  
//
//  Created by Wimes on 2022/09/12.
//

import ComposableArchitecture
import TCACoordinators

public struct BCoordinatorState: Equatable, IndexedRouterState {
    public var routes: [Route<BScreenState>]
    
    public init(routes: [Route<BScreenState>]) {
        self.routes = routes
    }
}

public enum BCoordinatorAction: IndexedRouterAction {
    case routeAction(Int, action: BScreenAction)
    case updateRoutes([Route<BScreenState>])
}

public struct BCoordinatorEnvrionment {
    public init() { }
}

public let bCoordinatorReducer: Reducer<
    BCoordinatorState,
    BCoordinatorAction,
    BCoordinatorEnvrionment
> = bScreenReducer
    .forEachIndexedRoute { _ in
        BScreenEnvironment()
    }
    .withRouteReducer(
        Reducer { state, action, environment in
            switch action {
            default:
                return .none
            }
        }
    )


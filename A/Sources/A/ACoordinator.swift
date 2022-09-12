//
//  File.swift
//  
//
//  Created by Wimes on 2022/09/12.
//

import ComposableArchitecture
import TCACoordinators

public struct ACoordinatorState: Equatable, IndexedRouterState {
    public var routes: [Route<AScreenState>]
    
    public init(routes: [Route<AScreenState>] = [.root(.a1(.init()), embedInNavigationView: true)]) {
        self.routes = routes
    }
}

public enum ACoordinatorAction: IndexedRouterAction {
    // @@ Int가 왜 들어갈까?
    case routeAction(Int, action: AScreenAction)
    case updateRoutes([Route<AScreenState>])
}

public struct ACoordinatorEnvironment {}

public let coordinatorReducer: Reducer<
    ACoordinatorState,
    ACoordinatorAction,
    ACoordinatorEnvironment
> = aScreenReducer
    .forEachIndexedRoute(environment: { _ in AScreenEnvironment() })
    .withRouteReducer(
        Reducer { state, action, environment in
          switch action {
          case .routeAction(_, action: .a1(.didTapButton)):
              state.routes.push(.a2(.init()))
            return .none
          case .routeAction(_, action: .a2(.didTapBack)):
            state.routes.pop()
            return .none
          default:
            return .none
          }
        }
      )


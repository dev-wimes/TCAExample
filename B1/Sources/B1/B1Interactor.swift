import Foundation
import Effects
import ComposableArchitecture

public struct B1State: Equatable {
    public var loginData: String = "empty"
    public var resultString: String = "..."
    
    public init() { }
}

public enum B1Action {
    case onAppear
    case dataLoaded(Result<String, ApiError>)
}

public struct B1Environment {
    var request: () -> Effect<String, ApiError>
    var mainQueue: () -> AnySchedulerOf<DispatchQueue>
    
    public init(
        request: @escaping () -> Effect<String, ApiError>,
        mainQueue: @escaping () -> AnySchedulerOf<DispatchQueue>
    ) {
        self.request = request
        self.mainQueue = mainQueue
    }
}

public let b1Reducer = Reducer<
    B1State,
    B1Action,
    B1Environment
> { state, action, environment in
    switch action {
    case .onAppear:
        state.resultString = "..."
        return environment.request()
            .receive(on: environment.mainQueue())
            .catchToEffect(B1Action.dataLoaded)
    case .dataLoaded(.success(let response)):
        state.resultString = response
        return .none
    case .dataLoaded(.failure(let error)):
        return .none
    }
}

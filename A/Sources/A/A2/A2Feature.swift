//
//  File.swift
//  
//
//  Created by Wimes on 2022/11/19.
//

import Foundation
import ComposableArchitecture
import WMNetwork
import NumberRepository

public struct A2Feature: ReducerProtocol {
    private let repository: NumberRepository = NumberRepositoryImpl()
    
    public init() { }
}

extension A2Feature {
    public struct State: Equatable {
        var resultString: String
        
        public init(defaultText: String = "...") {
            self.resultString = defaultText
        }
    }
}

extension A2Feature {
    public enum Action {
        case onAppear
        case dataLoaded(TaskResult<String>)
    }
}

extension A2Feature {
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.resultString = "..."
                
                return .run { send in
                    await send(.dataLoaded(self.repository.two()))
                }
            case let .dataLoaded(response):
                switch response {
                case let .success(result):
                    state.resultString = result
                case let .failure(error):
                    print("## error: \(error)")
                    break
                }
                
                return .none
            }
        }
    }

}

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

public struct B1Feature: ReducerProtocol {
    private let repository: NumberRepository = NumberRepositoryImpl()
    
    public init() { }
}

extension B1Feature {
    public struct State: Equatable {
        var loginData: String
        var resultString: String
        
        public init(loginData: String, defaultText: String = "...") {
            self.loginData = loginData
            self.resultString = defaultText
        }
    }
}

extension B1Feature {
    public enum Action {
        case onAppear
        case dataLoaded(TaskResult<String>)
    }
}

extension B1Feature {
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.resultString = "..."
                
                return .run { send in
                    await send(.dataLoaded(self.repository.one()))
                }
            case let .dataLoaded(response):
                switch response {
                case let .success(result):
                    state.resultString = result
                case let .failure(error):
                    print("## \(error)")
                    break
                }
                
                return .none
            }
        }
    }
}




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

public struct A1Feature: ReducerProtocol {
    private let repository: NumberRepository = NumberRepositoryImpl()
    
    public init() { }
}

extension A1Feature {
    public struct State: Equatable {
        var resultString: String
        public var a2: A2Feature.State?
        
        public init(defaultText: String = "...") {
            self.resultString = defaultText
        }
    }
}

extension A1Feature {
    public enum Action {
        case onAppear
        case dataLoaded(TaskResult<String>)
        case didTapButton
        case a2(A2Feature.Action)
    }
}

extension A1Feature {
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                print("@@ onAppear")
                state.resultString = "..."
                
                return .run { send in
                    await send(.dataLoaded(self.repository.one()))
                }
            case let .dataLoaded(response):
                print("@@ dataLoaded")
                switch response {
                case let .success(result):
                    print("@@ result: ", result)
                    state.resultString = result
                case let .failure(error):
                    print("## \(error)")
                    break
                }
                
                return .none
            case .didTapButton:
                state.a2 = A2Feature.State()
                return .none
            case .a2:
                return .none
            }
        }
    }
}



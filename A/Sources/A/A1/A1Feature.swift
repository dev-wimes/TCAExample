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
    
    public struct State: Equatable {
        var resultString: String
        public var a2: A2Feature.State?
        
        public init(defaultText: String = "...") {
            self.resultString = defaultText
        }
    }
    
    public enum Action {
        case onAppear
        case dataLoaded(TaskResult<String>)
        case didTapButton
        case a2(A2Feature.Action)
    }
    
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
                    print("## error: \(error)")
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
        .ifLet(
            \.a2,
             action: /Action.a2
        ) {
            A2Feature()
        }
    }
}

// MARK: (note) 아래처럼 extension으로 쓸 경우 타입추론이 안된다. body 부분에서 \.으로 타입추론중인데 여기서 에러
//extension A1Feature {
//    public struct State: Equatable {
//        var resultString: String
//        public var a2: A2Feature.State?
//
//        public init(defaultText: String = "...") {
//            self.resultString = defaultText
//        }
//    }
//}
//
//extension A1Feature {
//    public enum Action {
//        case onAppear
//        case dataLoaded(TaskResult<String>)
//        case didTapButton
//        case a2(A2Feature.Action)
//    }
//}
//
//extension A1Feature {
//    public var body: some ReducerProtocol<State, Action> {
//        Reduce { state, action in
//            switch action {
//            case .onAppear:
//                state.resultString = "..."
//
//                return .run { send in
//                    await send(.dataLoaded(self.repository.one()))
//                }
//            case let .dataLoaded(response):
//                switch response {
//                case let .success(result):
//                    state.resultString = result
//                case let .failure(error):
//                    print("## error: \(error)")
//                    break
//                }
//
//                return .none
//            case .didTapButton:
//                state.a2 = A2Feature.State()
//                return .none
//            case .a2:
//                return .none
//            }
//        }
//        .ifCaseLet(
//            \.a2,
//             action: /Action.a2
//        ) {
//            A2Feature()
//        }
//    }
//}
//
//

////
////  File.swift
////  
////
////  Created by Wimes on 2022/09/07.
////
//
//import ComposableArchitecture
//import Effects
//
//public enum AScreenState: Equatable {
//    case a1(A1State)
//    case a2(A2State)
//}
//
//public enum AScreenAction {
//    case a1(A1Action)
//    case a2(A2Action)
//}
//
//public struct AScreenEnvironment { }
//
//public let aScreenReducer = Reducer<
//    AScreenState,
//    AScreenAction,
//    AScreenEnvironment
//>.combine([
//    a1Reducer.pullback(
//        state: /AScreenState.a1,
//        action: /AScreenAction.a1,
//        environment: { _ in A1Environment() }
//    ),
//    a2Reducer.pullback(
//        state: /AScreenState.a2,
//        action: /AScreenAction.a2,
//        environment: { _ in A2Environment(
//            request: { EffectsImpl().numbersApiThree() },
//            mainQueue: { .main }
//        ) }
//    )
//])

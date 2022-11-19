////
////  SwiftUIView.swift
////  
////
////  Created by Wimes on 2022/09/12.
////
//
//import SwiftUI
//import ComposableArchitecture
//import TCACoordinators
//
//public struct ACoordinatorView: View {
//    let store: Store<ACoordinatorState, ACoordinatorAction>
//    
//    public init(store: Store<ACoordinatorState, ACoordinatorAction>) {
//        self.store = store
//    }
//    
//    public var body: some View {
//        TCARouter(store) { screen in
//            SwitchStore(screen) {
//                CaseLet(
//                    state: /AScreenState.a1,
//                    action: AScreenAction.a1,
//                    then: A1View.init
//                )
//                CaseLet(
//                    state: /AScreenState.a2,
//                    action: AScreenAction.a2,
//                    then: A2View.init
//                )
//            }
//        }
//    }
//}

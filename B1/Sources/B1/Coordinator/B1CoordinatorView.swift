////
////  File.swift
////  
////
////  Created by Wimes on 2022/09/12.
////
//
//import SwiftUI
//import ComposableArchitecture
//import TCACoordinators
//
//public struct BCoordinatorView: View {
//    let store: Store<BCoordinatorState, BCoordinatorAction>
//    
//    public init(store: Store<BCoordinatorState, BCoordinatorAction>) {
//        self.store = store
//    }
//    
//    public var body: some View {
//        TCARouter(store) { screen in
//            SwitchStore(screen) {
//                CaseLet(
//                    state: /BScreenState.b1,
//                    action: BScreenAction.b1,
//                    then: B1View.init
//                )
//            }
//        }
//    }
//}
//

////
////  RootCoordinatorView.swift
////  Modular-TCA
////
////  Created by Wimes on 2022/09/12.
////
//
//import SwiftUI
//import ComposableArchitecture
//import TCACoordinators
//
//
//struct RootCoordinatorView: View {
//    let store: Store<RootCoordinatorState, RootCoordinatorAction>
//    
//    var body: some View {
//        TCARouter(store) { screen in
//            SwitchStore(screen) {
//                CaseLet(
//                    state: /RootScreenState.login,
//                    action: RootScreenAction.login,
//                    then: LoginView.init
//                )
//                CaseLet(
//                    state: /RootScreenState.tabBar,
//                    action: RootScreenAction.tabBar,
//                    then: TabBarView.init
//                )
//            }
//        }
//    }
//}

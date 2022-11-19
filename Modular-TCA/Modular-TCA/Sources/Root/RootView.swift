//
//  RootView.swift
//  Modular-TCA
//
//  Created by Wimes on 2022/01/08.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    private let store: StoreOf<RootFeature>
    
    init(store: StoreOf<RootFeature>) {
        self.store = store
    }
    
    var body: some View {
        SwitchStore(self.store) {
            CaseLet(
                state: /RootFeature.State.login,
                action: RootFeature.Action.login
            ) { store in
                NavigationView {
                    LoginView(store: store)
                }
            }
            CaseLet(
                state: /RootFeature.State.tabBar,
                action: RootFeature.Action.tabBar
            ) { store in
                NavigationView {
                    TabBarView(store: store)
                }
            }
        }
    }
}

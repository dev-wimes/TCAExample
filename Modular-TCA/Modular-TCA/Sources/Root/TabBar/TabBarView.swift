//
//  TabBarView.swift
//  Modular-TCA
//
//  Created by Wimes on 2022/01/08.
//

import SwiftUI
import ComposableArchitecture
import A
import B1

struct TabBarView: View {
    let store: Store<TabBarState, TabBarAction>
    
    init(store: Store<TabBarState, TabBarAction>) {
        self.store = store
        
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithTransparentBackground()
        navigationAppearance.backgroundColor = .systemRed
        
        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance
        UINavigationBar.appearance().tintColor = .black
    }
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            TabView {
                ACoordinatorView(store: self.store.scope(
                    state: \.a,
                    action: TabBarAction.a
                ))
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("A")
                }
                
                BCoordinatorView(store: self.store.scope(
                    state: \.b,
                    action: TabBarAction.b
                ))
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("B")
                }
            }
            .onAppear {
                print("loginData: ", viewStore.loginData)
            }
        }
    }
}

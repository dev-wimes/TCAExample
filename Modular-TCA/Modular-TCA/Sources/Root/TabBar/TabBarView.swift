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
import B2

struct TabBarView: View {
    let store: Store<TabBarState, TabBarAction>
    
    init(store: Store<TabBarState, TabBarAction>) {
        self.store = store
        
        // @@ 사용하면 앱이 죽는다.
//        let coloredAppearance = UINavigationBarAppearance()
//        coloredAppearance.configureWithTransparentBackground()
//        coloredAppearance.backgroundColor = .systemRed
//        coloredAppearance.titleTextAttributes = [.foregroundColor: Color.white]
//
//        UINavigationBar.appearance().standardAppearance = coloredAppearance
//        UINavigationBar.appearance().compactAppearance = coloredAppearance
//        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
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
                
                NavigationView {
                    B1View(store: self.store.scope(
                        state: \.b1State,
                        action: TabBarAction.b1Action
                    ))
                }
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("B")
                }
            }
        }
    }
}

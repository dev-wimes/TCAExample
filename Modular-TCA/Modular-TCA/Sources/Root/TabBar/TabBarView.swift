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
    let store: StoreOf<TabBarFeature>
    
    init(store: StoreOf<TabBarFeature>) {
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
                A1View(store: self.store.scope(
                    state: \.a1,
                    action: TabBarFeature.Action.a1
                ))
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("A")
                }
                
                B1View(store: self.store.scope(
                    state: \.b1,
                    action: TabBarFeature.Action.b1
                ))
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("B")
                }
            }
        }
    }
}

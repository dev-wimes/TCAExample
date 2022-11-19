//
//  A1View.swift
//  
//
//  Created by Wimes on 2022/01/12.
//

import SwiftUI
import ComposableArchitecture

public struct A1View: View {
    let store: StoreOf<A1Feature>
    
    public init(store: StoreOf<A1Feature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                Text(viewStore.resultString)
                NavigationLink {
                    IfLetStore(
                        self.store.scope(
                            state: \.a2,
                            action: A1Feature.Action.a2)
                    ) { store in
                        A2View(store: store)
                    }
                } label: {
                    Text("open the A2 View")
                }
            }
            .navigationBarTitle("A1", displayMode: .inline)
            .onAppear {
                print("@@ View.onAppear")
                viewStore.send(.onAppear)
            }
        }
    }
}

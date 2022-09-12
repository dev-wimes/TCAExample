//
//  A1View.swift
//  
//
//  Created by Wimes on 2022/01/12.
//

import SwiftUI
import ComposableArchitecture
import Effects

public struct A1View: View {
    let store: Store<A1State, A1Action>
    
    public init(store: Store<A1State, A1Action>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                Text(viewStore.resultString)
                Button {
                    viewStore.send(.didTapButton)
                } label: {
                    Text("open the A2 View")
                }
            }
            .navigationTitle("A1")
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

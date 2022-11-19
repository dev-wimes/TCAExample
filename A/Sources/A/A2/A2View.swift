//
//  A2View.swift
//  
//
//  Created by Wimes on 2022/01/12.
//

import SwiftUI
import ComposableArchitecture

public struct A2View: View {
    
    let store: StoreOf<A2Feature>
    
    public init(store: StoreOf<A2Feature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                Text(viewStore.resultString)
            }
            .navigationBarTitle("A2", displayMode: .inline)
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}


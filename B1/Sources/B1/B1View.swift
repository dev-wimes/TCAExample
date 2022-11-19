//
//  B1View.swift
//  
//
//  Created by Wimes on 2022/01/10.
//

import SwiftUI
import ComposableArchitecture

public struct B1View: View {
    
    let store: StoreOf<B1Feature>
    
    public init(store: StoreOf<B1Feature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                Text("login Data: "+viewStore.loginData)
                Text(viewStore.resultString)
            }
            .navigationTitle("B1")
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

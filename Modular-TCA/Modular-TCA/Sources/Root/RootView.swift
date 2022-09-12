//
//  RootView.swift
//  Modular-TCA
//
//  Created by Wimes on 2022/01/08.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    let store: Store<RootState, RootAction>
    
    init(store: Store<RootState, RootAction>) {
        self.store = store
    }
    
    var body: some View {
        RootCoordinatorView(store: .init(
            initialState: .init(),
            reducer: rootCoordinatorReducer,
            environment: RootCoordinatorEnvironment()
        ))
    }
}

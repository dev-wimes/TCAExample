//
//  RootView.swift
//  Modular-TCA
//
//  Created by Wimes on 2022/01/08.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    var body: some View {
        RootCoordinatorView(store: .init(
            initialState: .init(),
            reducer: rootCoordinatorReducer,
            environment: RootCoordinatorEnvironment()
        ))
    }
}

//
//  LoginView.swift
//  Modular-TCA
//
//  Created by Wimes on 2022/01/08.
//

import SwiftUI
import ComposableArchitecture

struct LoginView: View {
    
    let store: Store<LoginState, LoginAction>
    
    var body: some View {
        WithViewStore(self.store){ viewStore in
            VStack {
                Button {
                    viewStore.send(.loggedIn(loginData: "I'm Signed In!"))
                } label: {
                    Text("logIn")
                }
            }
        }
    }
}

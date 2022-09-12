//
//  LoginInteractor.swift
//  Modular-TCA
//
//  Created by Wimes on 2022/01/08.
//

import Foundation
import ComposableArchitecture

struct LoginState: Equatable { }

enum LoginAction {
    case loggedIn(loginData: String)
}

struct LoginEnvironmnet { }

let loginReducer: Reducer<
    LoginState,
    LoginAction,
    LoginEnvironmnet
> = Reducer { _, _, _ in
    return .none
}

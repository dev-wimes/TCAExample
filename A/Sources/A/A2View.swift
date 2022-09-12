//
//  A2View.swift
//  
//
//  Created by Wimes on 2022/01/12.
//

import SwiftUI
import ComposableArchitecture

public struct A2View: View {
    
    let store: Store<A2State, A2Action>
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                Text("\(viewStore.resultString)")
            }
            .navigationBarTitle("A2", displayMode: .inline)
            // @@
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    self.backButton(viewStore: viewStore)
//                }
//            }
//            .navigationBarBackButtonHidden(true)
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
    
    // @@
//    @ViewBuilder
//    func backButton(viewStore: ViewStore<A2State, A2Action>) -> some View {
//        Button {
//            viewStore.send(.didTapBack)
//        } label: {
//            Image(systemName: "chevron.backward")
//        }
//    }
}


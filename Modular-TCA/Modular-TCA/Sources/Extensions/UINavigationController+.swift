//
//  UINavigationController+.swift
//  Modular-TCA
//
//  Created by Wimes on 2022/09/12.
//

import SwiftUI

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}

//
//  File.swift
//  
//
//  Created by Wimes on 2022/11/19.
//

import Foundation
import ComposableArchitecture
import WMNetwork

public protocol NumberRepository {
    func one() async -> TaskResult<String>
    func two() async -> TaskResult<String>
    func three() async -> TaskResult<String>
    func four() async -> TaskResult<String>
}

public final class NumberRepositoryImpl: WMNetworkSession, NumberRepository {
    public init() { }
    
    public func one() async -> TaskResult<String> {
        return await self.request(NumberTarget.one)
    }
    
    public func two() async -> TaskResult<String> {
        return await self.request(NumberTarget.one)
    }
    
    public func three() async -> TaskResult<String> {
        return await self.request(NumberTarget.one)
    }
    
    public func four() async -> TaskResult<String> {
        return await self.request(NumberTarget.one)
    }
}

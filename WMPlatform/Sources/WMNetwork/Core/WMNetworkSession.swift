//
//  File.swift
//  
//
//  Created by Wimes on 2022/11/19.
//

import Foundation
import ComposableArchitecture

public protocol WMNetworkSession {
    func request<T: Decodable>(_ api: BaseTargetType) async -> TaskResult<T>
}

public extension WMNetworkSession {
    func request<T: Decodable>(_ api: BaseTargetType) async -> TaskResult<T> {
        do {
            let sessionConfig = URLSessionConfiguration.default
            sessionConfig.timeoutIntervalForRequest = 60.0
            sessionConfig.timeoutIntervalForResource = 60.0
            let session = URLSession(configuration: sessionConfig)
            
            let (data, response) = try await session.data(for: api.request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(NetworkError.unknown)
            }
            
            if httpResponse.statusCode >= 200, httpResponse.statusCode < 300 {
                if let resultString = String(data: data, encoding: .utf8),
                   let result = resultString as? T {
                    return .success(result)
                } else if let result = try? JSONDecoder().decode(T.self, from: data) {
                    return .success(result)
                } else {
                    return .failure(NetworkError.parsing)
                }
            } else {
                return .failure(NetworkError.badRequest)
            }
        } catch {
            return .failure(NetworkError.serverError(error))
        }
    }
}

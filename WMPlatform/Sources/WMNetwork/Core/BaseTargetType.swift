//
//  File.swift
//  
//
//  Created by Wimes on 2022/11/19.
//

import Foundation

public protocol BaseTargetType {
    var request: URLRequest { get }
    var parameter: [String: Any]? { get }
    var path: String { get }
    var body: [String: Any]? { get }
    var method: HttpMethod { get }
}

extension BaseTargetType {
    var baseUrl: String {
        return "numbersapi.com"
    }

    var header: [String: String] {
        return [
            "Content-Type": "application/json",
        ]
    }

    var url: URL {
        var components = URLComponents()

        components.scheme = "https"
        components.host = baseUrl
        components.path = path
        components.queryItems = []

        parameter?.forEach {
            components.queryItems?.append(URLQueryItem(
                name: $0.key,
                value: "\($0.value)"
            ))
        }

        if let url = components.url {
            return url
        } else {
            return URL(string: "")!
        }
    }

    var body: [String: Any]? {
        return nil
    }

    public var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        header.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }

        if let body {
            guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
                assertionFailure("JsonData로 형변환에 실패했습니다.")
                return request
            }
            request.httpBody = jsonData
        }

        return request
    }
}

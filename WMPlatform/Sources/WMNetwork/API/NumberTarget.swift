//
//  File.swift
//  
//
//  Created by Wimes on 2022/11/19.
//

import Foundation

public enum NumberTarget {
    case one
    case two
    case three
    case four
}

extension NumberTarget: BaseTargetType {
    public var body: [String: Any]? { nil }
    
    public var path: String {
        switch self {
        case .one:
            return "/1"
        case .two:
            return "/2"
        case .three:
            return "/3"
        case .four:
            return "/4"
        }
    }

    public var method: HttpMethod {
        switch self {
        default:
            return .get
        }
    }

    public var parameter: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
}

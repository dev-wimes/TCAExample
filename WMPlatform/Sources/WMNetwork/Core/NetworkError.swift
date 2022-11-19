//
//  File.swift
//  
//
//  Created by Wimes on 2022/11/19.
//

import Foundation

public enum NetworkError: Error {
    case unknown
    case serverError(Error)
    case badRequest
    case parsing
}

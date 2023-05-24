//
//  File.swift
//  
//
//  Created by H G on 2023/05/21.
//

import Foundation

extension Network {
    public enum Param {
        case page(page: Int)
        case text(text: String)
        case extras(extras: [Extras])

        func build() -> URLQueryItem {
            switch self {
            case let .page(page):
                return .init(name: "page", value: String(page))
            case let .text(text):
                return .init(name: "text", value: text)
            case let .extras(extras):
                return .init(name: "extras", value: extras.map { $0.rawValue }.joined(separator: ","))
            }
        }
    }
    
    public enum Extras: String  {
        case description
        case date_upload
        case date_taken
        case owner_name
        case geo
        case url_m
    }
}

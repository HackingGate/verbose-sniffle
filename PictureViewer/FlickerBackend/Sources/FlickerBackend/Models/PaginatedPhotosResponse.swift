//
//  PaginatedResponse.swift
//  
//
//  Created by H G on 2023/05/21.
//

import Foundation

public struct PaginatedPhotosResponse: Codable {
    public let page: Int
    public let pages: Int
    public let perpage: Int
    public let total: Int
    public let photo: [Photo]
}

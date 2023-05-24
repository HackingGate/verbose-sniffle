//
//  File.swift
//  
//
//  Created by H G on 2023/05/21.
//

import Foundation

public struct PhotosResponse: Codable {
    public let stat: String
    public let photos: PaginatedPhotosResponse
}

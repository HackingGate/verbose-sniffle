//
//  Methods.swift
//  
//
//  Created by H G on 2023/05/21.
//

import Foundation

extension Network {
    public enum Method {
        case flickrPhotosSearch
        
        public func build() -> String {
            switch self {
            case .flickrPhotosSearch:
                return "flickr.photos.search"
            }
        }
    }
}

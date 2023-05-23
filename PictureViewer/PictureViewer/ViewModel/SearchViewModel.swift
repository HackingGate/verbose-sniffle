//
//  SearchViewModel.swift
//  PictureViewer
//
//  Created by H G on 2023/05/24.
//

import Foundation
import FlickerBackend

@MainActor
class SearchViewModel: ObservableObject {
    @Published private(set) var flickrPhotosSearchResponse: PhotosResponse?
    
    @Published var error: Error?
    
    public func flickrPhotosSearch(text: String) async {
        do {
            async let flickrPhotosSearchResponse: PhotosResponse = Network.shared.GET(method: .flickrPhotosSearch, params: [.text(text: text), .extras(extras: [.url_m, .owner_name])])
            try await self.flickrPhotosSearchResponse = flickrPhotosSearchResponse
        } catch let error {
            self.error = error
        }
    }
}

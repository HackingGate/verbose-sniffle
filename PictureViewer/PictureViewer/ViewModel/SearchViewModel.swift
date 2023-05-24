//
//  SearchViewModel.swift
//  PictureViewer
//
//  Created by H G on 2023/05/24.
//

import Foundation
import FlickerBackend
import RealmSwift

@MainActor
class SearchViewModel: ObservableObject {
    @Published private(set) var photos: [PersistedPhoto] = []
    @Published var error: Error?
    
    private let photoService = PhotoService()
    
    init() {
        readSavedPhotos()
    }
    
    public func flickrPhotosSearch(text: String) async {
        do {
            async let flickrPhotosSearchResponse: PhotosResponse = Network.shared.GET(method: .flickrPhotosSearch, params: [.text(text: text), .extras(extras: [.url_m, .owner_name])])
            try await photoService.convertAndSavePhotos(flickrPhotos: flickrPhotosSearchResponse.photos.photo)
            photos = photoService.convertPhotos()
        } catch let error {
            self.error = error
        }
    }
    
    public func readSavedPhotos() {
        photos = photoService.readPhotos()
    }
}

class PhotoService {
    let realm = try! Realm()

    func convertAndSavePhotos(flickrPhotos: [Photo]) {
        do {
            try realm.write {
                realm.deleteAll()
                for flickrPhoto in flickrPhotos {
                    let photo = PersistedPhoto()
                    photo.id = flickrPhoto.id
                    photo.title = flickrPhoto.title
                    photo.url_m = flickrPhoto.url_m ?? ""

                    realm.add(photo, update: .modified)
                }
            }
        } catch {
            print("Error saving photos: \(error)")
        }
    }
    
    func convertPhotos() -> [PersistedPhoto] {
        let persistedPhotos = realm.objects(PersistedPhoto.self)
        var convertedPhotos: [PersistedPhoto] = []
        persistedPhotos.forEach { persistedPhoto in
            convertedPhotos.append(
                PersistedPhoto(value: [
                    "id": persistedPhoto.id,
                    "title": persistedPhoto.title,
                    "url_m": persistedPhoto.url_m
                ])
            )
        }
        
        return convertedPhotos
    }
    
    func readPhotos() -> [PersistedPhoto] {
        let persistedPhotos = realm.objects(PersistedPhoto.self)
        return Array(persistedPhotos)
    }

}

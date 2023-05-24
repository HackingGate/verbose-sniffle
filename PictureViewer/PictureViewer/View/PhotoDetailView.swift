//
//  PhotoDetailView.swift
//  PictureViewer
//
//  Created by H G on 2023/05/24.
//

import SwiftUI
import FlickrBackend
import Kingfisher

struct PhotoDetailView: View {
    var photo: PersistedPhoto
    
    var body: some View {
        VStack {
            Text(photo.title)
                .font(.title)
            KFImage(URL(string: photo.url_m ))
                .resizable()
                .scaledToFit()
        }
        .padding(.bottom, 100)
    }
}

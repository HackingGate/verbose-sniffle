//
//  WaterfallView.swift
//  PictureViewer
//
//  Created by H G on 2023/05/24.
//

import SwiftUI
import FlickrBackend

struct WaterfallView<Content: View>: View {
    var photos: [PersistedPhoto]
    var content: (PersistedPhoto) -> Content
    
    init(photos: [PersistedPhoto], @ViewBuilder content: @escaping (PersistedPhoto) -> Content) {
        self.photos = photos
        self.content = content
    }

    var body: some View {
        ScrollView {
            HStack(alignment: .top, spacing: 10) {
                VStack(spacing: 10) {
                    ForEach(photos.indices.filter { $0.isMultiple(of: 2) }, id: \.self) { index in
                        content(photos[index])
                    }
                }
                VStack(spacing: 10) {
                    ForEach(photos.indices.filter { !$0.isMultiple(of: 2) }, id: \.self) { index in
                        content(photos[index])
                    }
                }
            }.padding()
        }
    }
}

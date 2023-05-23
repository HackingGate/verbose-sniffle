//
//  WaterfallView.swift
//  PictureViewer
//
//  Created by H G on 2023/05/24.
//

import SwiftUI
import FlickerBackend

struct WaterfallView<Content: View>: View {
    var photos: [Photo]
    var content: (Photo) -> Content
    
    init(photos: [Photo], @ViewBuilder content: @escaping (Photo) -> Content) {
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

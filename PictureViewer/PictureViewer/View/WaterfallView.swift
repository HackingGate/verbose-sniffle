//
//  WaterfallView.swift
//  PictureViewer
//
//  Created by H G on 2023/05/24.
//

import SwiftUI
import FlickerBackend
import Kingfisher

struct WaterfallView: View {
    @State var photos: [Photo] = []

    var body: some View {
        ScrollView {
            HStack(alignment: .top, spacing: 10) {
                VStack(spacing: 10) {
                    ForEach(photos.indices.filter { $0.isMultiple(of: 2) }, id: \.self) { index in
                        KFImage(URL(string: photos[index].url_m ?? ""))
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                    }
                }
                VStack(spacing: 10) {
                    ForEach(photos.indices.filter { !$0.isMultiple(of: 2) }, id: \.self) { index in
                        KFImage(URL(string: photos[index].url_m ?? ""))
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                    }
                }
            }.padding()
        }
    }
}

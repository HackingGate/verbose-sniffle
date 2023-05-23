//
//  SearchView.swift
//  PictureViewer
//
//  Created by H G on 2023/05/20.
//

import SwiftUI
import Kingfisher

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()

    @State private var searchText: String = ""
    
    @Environment(\.dismissSearch) var dismissSearch

    var body: some View {
        NavigationView  {
            VStack {
                if let error = viewModel.error {
                    Text(error.localizedDescription)
                } else if viewModel.flickrPhotosSearchResponse == nil {
                    Text("No data")
                } else if let flickrPhotosSearchResponse = viewModel.flickrPhotosSearchResponse {
                    WaterfallView(photos: flickrPhotosSearchResponse.photos.photo) { photo in
                        NavigationLink(destination: PhotoDetailView(photo: photo)) {
                            KFImage(URL(string: photo.url_m ?? ""))
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                        }
                    }
                } else {
                    Text("Loading...")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .searchable(text: $searchText, prompt: "Search text here...")
            .onSubmit(of: .search) {
                Task {
                    await viewModel.flickrPhotosSearch(text: searchText)
                    dismissSearch()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

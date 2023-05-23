//
//  SearchView.swift
//  PictureViewer
//
//  Created by H G on 2023/05/20.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()

    @State private var searchText: String = ""
    
    @Environment(\.dismissSearch) var dismissSearch
    
    let suggestions: [String] = [
        "Tokyo Night Views", "New York City", "Paris"
    ]


    var body: some View {
        NavigationView  {
            VStack {
                if let error = viewModel.error {
                    Text(error.localizedDescription)
                } else if viewModel.flickrPhotosSearchResponse == nil {
                    Text("No data")
                } else if let flickrPhotosSearchResponse = viewModel.flickrPhotosSearchResponse {
                    WaterfallView(photos: flickrPhotosSearchResponse.photos.photo)
                } else {
                    Text("Loading...")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .searchable(text: $searchText, prompt: "Search text here...") {
                ForEach(suggestions, id: \.self) { suggestion in
                    Text(suggestion)
                        .searchCompletion(suggestion)
                }
            }
            .onSubmit(of: .search) {
                Task {
                    await viewModel.flickrPhotosSearch(text: searchText)
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

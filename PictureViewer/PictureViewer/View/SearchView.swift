//
//  ContentView.swift
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
            List(viewModel.flickrPhotosSearchResponse?.photos.photo ?? []) { photo in
                Text(photo.title)
            }
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
                dismissSearch()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

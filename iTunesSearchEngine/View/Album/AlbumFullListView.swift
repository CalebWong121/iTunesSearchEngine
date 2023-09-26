//
//  AlbumFullListView.swift
//  iTunesSearchEngine
//
//  Created by Wong Ka Ho Caleb on 2023/9/25.
//

import SwiftUI

struct AlbumFullListView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        VStack {
            switch viewModel.fetchStatus {
            case .normal, .loading:
                ScrollView {
                    ForEach(viewModel.albums.indices, id: \.self){ index in
                        if let artworkUrl60 = viewModel.albums[index].artworkUrl60,
                           let collectionName = viewModel.albums[index].collectionName,
                           let artistName = viewModel.albums[index].artistName,
                           let currency = viewModel.albums[index].currency,
                           let collectionPrice = viewModel.albums[index].collectionPrice,
                           let collectionID = viewModel.albums[index].collectionID
                        {
                            AlbumResultView(
                                viewModel: viewModel,
                                artworkUrl60: artworkUrl60,
                                collectionName: collectionName,
                                artistName: artistName,
                                currency: currency,
                                collectionPrice: collectionPrice,
                                collectionID: collectionID
                            )
                        }
                    }
                }
            case .noResult:
                Text("No result found")
//            case .loading:
//                ProgressView()
//                    .progressViewStyle(.circular)
            case .error(let message):
                Text("Error: \(message)")
            }
            
        }
        .navigationTitle("Albums")
        .onAppear {
            viewModel.limit = nil
            viewModel.fetchAlbum(term: viewModel.searchTerm)
        }
    }
}

struct AlbumFullListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumFullListView(viewModel: ViewModel())
    }
}

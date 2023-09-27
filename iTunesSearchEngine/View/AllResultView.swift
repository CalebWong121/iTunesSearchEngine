//
//  AllResultView.swift
//  iTunesSearchEngine
//
//  Created by Wong Ka Ho Caleb on 2023/9/26.
//

import SwiftUI

struct AllResultView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        ScrollView {
            VStack (spacing: 0) {
                SongPreviewListView(viewModel: viewModel)
                if !viewModel.songs.isEmpty {
                }
            }
            VStack (spacing: 0) {
                AlbumPreviewListView(viewModel: viewModel)
                if !viewModel.albums.isEmpty {
                }
                
            }
            
        }
        .navigationTitle("Results")
//        .onAppear {
//            viewModel.limit = 5
//            viewModel.fetchSong(term: viewModel.searchTerm)
//            viewModel.fetchAlbum(term: viewModel.searchTerm)
//            
//        }
    }
}

struct AllResultView_Previews: PreviewProvider {
    static var previews: some View {
        AllResultView(viewModel: ViewModel())
    }
}

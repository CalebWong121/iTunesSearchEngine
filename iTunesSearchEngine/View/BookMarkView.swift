//
//  BookMarkView.swift
//  iTunesSearchEngine
//
//  Created by Wong Ka Ho Caleb on 2023/9/27.
//

import SwiftUI

struct BookMarkView: View {
    
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        ScrollView {
            if viewModel.bookMarkList.isEmpty {
                Text("There is no book marked song now")
            } else {
                ForEach(viewModel.bookMarkList.indices, id: \.self){ index in
                    SongResultView(
                        viewModel: viewModel,
                        artworkUrl60: viewModel.bookMarkList[index].artworkUrl60!,
                        trackName: viewModel.bookMarkList[index].trackName!,
                        artistName: viewModel.bookMarkList[index].artistName!,
                        currency: viewModel.bookMarkList[index].currency!,
                        trackPrice: viewModel.bookMarkList[index].trackPrice!,
                        artistID: viewModel.bookMarkList[index].artistID!,
                        trackID: viewModel.bookMarkList[index].trackID!,
                        bookMark: { viewModel.bookMark(song: viewModel.bookMarkList[index]) }
                    )
                }
            }
        }
        .navigationTitle("Book Mark")
    }
}

struct BookMarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookMarkView(viewModel: ViewModel())
    }
}
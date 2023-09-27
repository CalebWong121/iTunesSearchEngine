//
//  AlbumFullListView.swift
//  iTunesSearchEngine
//
//  Created by Wong Ka Ho Caleb on 2023/9/25.
//

import SwiftUI

struct AlbumFullListView: View {
    @ObservedObject var viewModel: ViewModel
    @State var page: Int = 1
    var filteredList: [Album] {
        return viewModel.albums.filter({
            $0.artworkUrl60 != nil &&
            $0.collectionName != nil &&
            $0.artistName != nil &&
            $0.currency != nil &&
            $0.collectionPrice != nil &&
            $0.collectionID != nil
        })
    }
    var maxPage: Int {
        return Int(ceil(Double(filteredList.count) / 20.0))
    }
    
    var body: some View {
        VStack {
            switch viewModel.albumsFetchStatus {
            case .normal:
                ScrollViewReader { scrollViewProxy in
                    ScrollView {
                        HStack {
                            Text("Page \(page) in \(maxPage)")
                            Spacer()
                            Text("\(filteredList.count) results found")
                        }
                        .padding(.horizontal, 20)
                        ForEach(filteredList.indices, id: \.self){ index in
                            if index + 1 > ( page - 1 ) * 20 && index + 1 <= page * 20 {
                                AlbumResultView(
                                    viewModel: viewModel,
                                    artworkUrl60: filteredList[index].artworkUrl60!,
                                    collectionName: filteredList[index].collectionName!,
                                    artistName: filteredList[index].artistName!,
                                    currency: filteredList[index].currency!,
                                    collectionPrice: filteredList[index].collectionPrice!,
                                    collectionID: filteredList[index].collectionID!
                                )
                            }
                        }
                        HStack {
                            Spacer()
                            Button {
                                if page > 1 {
                                    page -= 1
                                    scrollViewProxy.scrollTo(0, anchor: .top)
                                }
                            } label: {
                                Image(systemName: "arrowtriangle.backward.fill")
                            }
                            Spacer()
                            Button {
                                if page < maxPage {
                                    page += 1
                                    scrollViewProxy.scrollTo(0, anchor: .top)
                                }
                            } label: {
                                Image(systemName: "arrowtriangle.forward.fill")
                            }
                            Spacer()
                        }
                        .padding(.vertical, 20)
                    }
                }
            case .noResult:
                Text("No result found")
            case .loading:
                ProgressView()
                    .progressViewStyle(.circular)
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

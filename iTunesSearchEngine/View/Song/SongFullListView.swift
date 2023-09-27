import SwiftUI

struct SongFullListView: View {
    @ObservedObject var viewModel: ViewModel
    
    @State var page: Int = 1
    var filteredList: [Song] {
        return viewModel.songs.filter({
            $0.artworkUrl60 != nil &&
            $0.trackName != nil &&
            $0.artistName != nil &&
            $0.currency != nil &&
            $0.trackPrice != nil &&
            $0.collectionID != nil &&
            $0.artistID != nil &&
            $0.trackID != nil &&
            $0.previewURL != nil
        })
    }
    var maxPage: Int {
        return Int(ceil(Double(filteredList.count) / 20.0))
    }
    var id: Int? = nil
    @State var isIn: Bool = false
    var body: some View {
        VStack {
            switch viewModel.songsFetchStatus {
            case .normal:
                ScrollViewReader { scrollViewProxy in
                    ScrollView {
                        HStack {
                            Text("\(AppString.page[viewModel.language]!) \(page) / \(maxPage)")
                            Spacer()
                            Text("\(filteredList.count) \(AppString.resultsFound[viewModel.language]!)")
                        }
                        .padding(.horizontal, 20)
                        ForEach(filteredList.indices, id: \.self){ index in
                            if index + 1 > ( page - 1 ) * 20 && index + 1 <= page * 20 {
                                SongResultView(
                                    viewModel: viewModel,
                                    artworkUrl60: filteredList[index].artworkUrl60!,
                                    trackName: filteredList[index].trackName!,
                                    artistName: filteredList[index].artistName!,
                                    currency: filteredList[index].currency!,
                                    trackPrice: filteredList[index].trackPrice!,
                                    artistID: filteredList[index].artistID!,
                                    trackID: filteredList[index].trackID!,
                                    previewURL: filteredList[index].previewURL!,
                                    bookMark: {
                                        viewModel.bookMark(song: filteredList[index])
//                                        print("Hi")
                                    }
                                    
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
                Text(AppString.noResultFound[viewModel.language]!)
            case .loading:
                ProgressView()
                    .progressViewStyle(.circular)
            case .error(let message):
                Text("Error: \(message)")
            }
        }
        .navigationTitle(AppString.songs[viewModel.language]!)
        .onAppear {
            if !isIn {
                viewModel.limit = nil
                viewModel.fetchSong(term: viewModel.searchTerm, id: id)
                isIn = true
            }
        }
    }
}

struct SongFullListView_Previews: PreviewProvider {
    static var previews: some View {
        SongFullListView(viewModel: ViewModel())
    }
}

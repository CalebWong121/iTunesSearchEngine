import SwiftUI

struct SongPreviewListView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var filteredList: [Song] {
        return viewModel.songs.filter({
            $0.artworkUrl100 != nil &&
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
    
    var body: some View {
        HStack {
            Text(AppString.songs[viewModel.language]!)
            Spacer()
            NavigationLink {
                SongFullListView(viewModel: viewModel)
            } label: {
                Text("\(AppString.more[viewModel.language]!) >")
                    .foregroundColor(.gray)
                    .font(.footnote)
                
            }
        }
        .padding(10)
        .onAppear {
            viewModel.limit = 5
            viewModel.fetchSong(term: viewModel.searchTerm)            
        }
        Divider()
        switch viewModel.songsFetchStatus {
        case .normal:
            ScrollView(.horizontal) {
                HStack {
                    ForEach(filteredList.indices, id: \.self){ index in
                        SongResultView(
                            viewModel: viewModel,
                            artworkUrl100: filteredList[index].artworkUrl100!,
                            trackName: filteredList[index].trackName!,
                            artistName: filteredList[index].artistName!,
                            currency: filteredList[index].currency!,
                            trackPrice: filteredList[index].trackPrice!,
                            artistID: filteredList[index].artistID!,
                            trackID: filteredList[index].trackID!,
                            previewURL: filteredList[index].previewURL!,
                            bookMark: {
                                viewModel.bookMark(song: filteredList[index])
                            }
                        )
                    }
                    .frame(width: 150)
                }
            }
            .frame(height: 200)
        case .noResult:
            Text(AppString.noResultFound[viewModel.language]!)
        case .loading:
            ProgressView()
                .progressViewStyle(.circular)
        case .error(let message):
            Text("Error: \(message)")
        }
    }
}

struct SongListView_Previews: PreviewProvider {
    static var previews: some View {
        SongPreviewListView(viewModel: ViewModel())
    }
}

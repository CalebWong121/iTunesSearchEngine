import SwiftUI

struct SongPreviewListView: View {
    
    @ObservedObject var viewModel: ViewModel
    
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
            ForEach(viewModel.songs.indices, id: \.self){ index in
                if let artworkUrl60 = viewModel.songs[index].artworkUrl60,
                   let trackName = viewModel.songs[index].trackName,
                   let artistName = viewModel.songs[index].artistName,
                   let currency = viewModel.songs[index].currency,
                   let trackPrice = viewModel.songs[index].trackPrice,
                   let artistID = viewModel.songs[index].artistID,
                   let trackID = viewModel.songs[index].trackID,
                   let previewURL = viewModel.songs[index].previewURL
                {
                    SongResultView(
                        viewModel: viewModel,
                        artworkUrl60: artworkUrl60,
                        trackName: trackName,
                        artistName: artistName,
                        currency: currency,
                        trackPrice: trackPrice,
                        artistID: artistID,
                        trackID: trackID,
                        previewURL: previewURL,
                        bookMark: { viewModel.bookMark(song: viewModel.songs[index]) }
                    )
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
}

struct SongListView_Previews: PreviewProvider {
    static var previews: some View {
        SongPreviewListView(viewModel: ViewModel())
    }
}

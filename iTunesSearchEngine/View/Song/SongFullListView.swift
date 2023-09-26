import SwiftUI

struct SongFullListView: View {
    @ObservedObject var viewModel: ViewModel
    var id: Int? = nil
    var body: some View {
        VStack {
            switch viewModel.fetchStatus {
            case .normal:
                ScrollView {
                    if !viewModel.songs.isEmpty {
                        ForEach(viewModel.songs.indices, id: \.self){ index in
                            if let artworkUrl60 = viewModel.songs[index].artworkUrl60,
                               let trackName = viewModel.songs[index].trackName,
                               let artistName = viewModel.songs[index].artistName,
                               let currency = viewModel.songs[index].currency,
                               let trackPrice = viewModel.songs[index].trackPrice,
                               let artistID = viewModel.songs[index].artistID
                            {
                                SongResultView(
                                    viewModel: viewModel,
                                    artworkUrl60: artworkUrl60,
                                    trackName: trackName,
                                    artistName: artistName,
                                    currency: currency,
                                    trackPrice: trackPrice,
                                    artistID: artistID
                                )
                            }
                        }
                        
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
        .navigationTitle("Songs")
//        .onAppear {
//            viewModel.limit = nil
//            viewModel.fetchSong(term: viewModel.searchTerm, id: id)
//        }
    }
}

struct SongFullListView_Previews: PreviewProvider {
    static var previews: some View {
        SongFullListView(viewModel: ViewModel())
    }
}

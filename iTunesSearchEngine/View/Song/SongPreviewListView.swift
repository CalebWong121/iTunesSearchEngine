import SwiftUI

struct SongPreviewListView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            Text("Songs")
            Spacer()
            NavigationLink {
                SongFullListView(viewModel: viewModel)
            } label: {
                Text("More >")
                    .foregroundColor(.gray)
                    .font(.footnote)
                
            }
        }
        .padding(10)
        Divider()
        switch viewModel.fetchStatus {
        case .normal:
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
        case .noResult:
            Text("No result found")
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

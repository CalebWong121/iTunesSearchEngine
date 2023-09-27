import SwiftUI

struct SongResultView: View {
    @ObservedObject var viewModel: ViewModel
    var artworkUrl60: String
    var trackName: String
    var artistName: String
    var currency: String
    var trackPrice: Double
    var artistID: Int
    var trackID: Int
    var previewURL: String
    
    var bookMark: () -> Void
    
    @State var shouldNav: Bool = false
    var isPreviewing: Bool {
        return viewModel.audioTrackID == trackID
    }
    var body: some View {
        GeometryReader { geometry in
            HStack (spacing: 0) {
                ImageView(urlString: artworkUrl60)
                    .cornerRadius(10)
                    .padding(10)
                    .frame(width: geometry.size.height)
                    
                VStack (alignment: .leading, spacing: 8) {
                    Text(trackName)
                        .font(.headline)
                        .onTapGesture {
//                            viewModel.fetchSong(term: trackName)
//                            viewModel.fetchAlbum(term: trackName)
                        }
                    ZStack {
                        Text(artistName)
                            .font(.subheadline)
                            .onTapGesture {
//                                viewModel.limit = nil
//                                viewModel.fetchSong(term: viewModel.searchTerm)
                                shouldNav = true
                            }
                        NavigationLink(isActive: $shouldNav) {
                            SongFullListView(viewModel: viewModel, id: artistID)
                        } label: {
                            EmptyView()
                        }
                    }
                }
                Spacer()
                HStack (spacing: 20) {
                    Image(systemName: viewModel.bookMarkList.map({$0.trackID}).contains(trackID) ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .onTapGesture {
                            bookMark()
                        }
                    Image(systemName: isPreviewing ? "stop.fill" : "play.fill")
                        .onTapGesture {
                            if !isPreviewing {
                                viewModel.playAudio(from: URL(string: previewURL)!, for: trackID)
                            } else {
                                viewModel.stopAudio()
                            }
                        }
                        .onDisappear {
                            viewModel.stopAudio()
                        }
//                    Text("\(currency)")
//                        .font(.subheadline)
//                    Text(String(format: "%.2f", trackPrice))
//                        .font(.subheadline)
                }
                .padding(20)
            }
        }
        .frame(height: 80)
    }
}

struct SongResultView_Previews: PreviewProvider {
    static var previews: some View {
        SongResultView(
            viewModel: ViewModel(),
            artworkUrl60: "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/ed/17/65/ed17656f-4c55-97c2-c93d-4b94f829799f/859381157694.jpg/60x60bb.jpg",
            trackName: "Never Gonna Give You Up",
            artistName: "Rick Astley",
            currency: "USD",
            trackPrice: 1.29,
            artistID: 669771,
            trackID: 123,
            previewURL: "123",
            bookMark: { print("BookMark") }
        )

    }
}

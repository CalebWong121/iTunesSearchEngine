import SwiftUI
import Kingfisher

struct SongResultView: View {
    @ObservedObject var viewModel: ViewModel
    var artworkUrl100: String
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
        VStack (spacing: 0) {
            ZStack {
                KFImage(URL(string: artworkUrl100))
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                
                Image(systemName: isPreviewing ? "stop.fill" : "play.fill")
                    .scaleEffect(3)
                    .font(.title)
                    .opacity(0.5)
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
            }
            VStack (alignment: .leading, spacing: 0) {
                Text(trackName)
                    .font(.headline)
                    .lineLimit(1)
                HStack {
                    Text(artistName)
                        .font(.subheadline)
                        .lineLimit(1)
                    Spacer()
                    Image(systemName: viewModel.bookMarkList.map({$0.trackID}).contains(trackID) ? "star.fill" : "star")
                        .font(.title)
                        .foregroundColor(.yellow)
                        .onTapGesture {
                            bookMark()
                        }
                }
            }
            .padding(10)
        }
        .background(Color.gray.opacity(0.3).cornerRadius(20))
        
    }
}

struct SongResultView_Previews: PreviewProvider {
    static var previews: some View {
        var column: [GridItem] = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        ScrollView {
            LazyVGrid(columns: column) {
                SongResultView(
                    viewModel: ViewModel(),
                    artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/ed/17/65/ed17656f-4c55-97c2-c93d-4b94f829799f/859381157694.jpg/60x60bb.jpg",
                    trackName: "Never Gonna Give You Up",
                    artistName: "Rick Astley",
                    currency: "USD",
                    trackPrice: 1.29,
                    artistID: 669771,
                    trackID: 123,
                    previewURL: "123",
                    bookMark: { print("BookMark") }
                )
                SongResultView(
                    viewModel: ViewModel(),
                    artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/ed/17/65/ed17656f-4c55-97c2-c93d-4b94f829799f/859381157694.jpg/60x60bb.jpg",
                    trackName: "Never Gonna Give You Up",
                    artistName: "Rick Astley",
                    currency: "USD",
                    trackPrice: 1.29,
                    artistID: 669771,
                    trackID: 123,
                    previewURL: "123",
                    bookMark: { print("BookMark") }
                )
                SongResultView(
                    viewModel: ViewModel(),
                    artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/ed/17/65/ed17656f-4c55-97c2-c93d-4b94f829799f/859381157694.jpg/60x60bb.jpg",
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
    }
}

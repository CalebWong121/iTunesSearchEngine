import SwiftUI
import Kingfisher

struct AlbumResultView: View {
    @ObservedObject var viewModel: ViewModel
    var artworkUrl60: String
    var collectionName: String
    var artistName: String
    var currency: String
    var collectionPrice: Double
    var collectionID: Int
    
    @State var shouldNav: Bool = false
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                HStack (spacing: 0) {
                    KFImage(URL(string: artworkUrl60))
                        .resizable()
                        .cornerRadius(10)
                        .padding(10)
                        .frame(width: geometry.size.height)
                    VStack (alignment: .leading, spacing: 8) {
                        Text(collectionName)
                            .font(.headline)
                        Text(artistName)
                            .font(.subheadline)
                    }
                    Spacer()
                }
            }
            .onTapGesture {
                shouldNav = true
            }

            NavigationLink(isActive: $shouldNav) {
                SongFullListView(viewModel: viewModel, id: collectionID)
            } label: {
                EmptyView()
            }


        }
        .frame(height: 80)
    }
}

struct AlbumResultView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumResultView(
            viewModel: ViewModel(),
            artworkUrl60: "https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/12/6d/fb/126dfb9f-94dc-8d7a-e368-97b298fe8b58/193436283403_NKOTBBBTTFINALhiresx.jpg/60x60bb.jpg",
            collectionName: "Bring Back the Time (feat. En Vogue, Rick Astley & Salt-N-Pepa) - Single",
            artistName: "New Kids On the Block",
            currency: "USD",
            collectionPrice: 0.69,
            collectionID: 1610829136)
    }
}

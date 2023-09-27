import SwiftUI

struct AlbumPreviewListView: View {
    
    @ObservedObject var viewModel: ViewModel
    @State var shouldNav: Bool = false
    var body: some View {
        VStack {
            HStack {
                Text("Albums")
                Spacer()
                ZStack {
                    
                    Text("More >")
                        .foregroundColor(.gray)
                        .font(.footnote)
                        .onTapGesture {
                            shouldNav = true
                            
                        }
                    NavigationLink(isActive: $shouldNav) {
                        AlbumFullListView(viewModel: viewModel)
    //                    SongFullListView(viewModel: viewModel, id: 1610829136)
                    } label: {
                        EmptyView()

                    }
                }
            }
            .padding(10)
            
            Divider()
            switch viewModel.albumsFetchStatus {
            case .normal:
                ForEach(viewModel.albums.indices, id: \.self){ index in
                    if let artworkUrl60 = viewModel.albums[index].artworkUrl60,
                       let collectionName = viewModel.albums[index].collectionName,
                       let artistName = viewModel.albums[index].artistName,
                       let currency = viewModel.albums[index].currency,
                       let collectionPrice = viewModel.albums[index].collectionPrice,
                       let collectionID = viewModel.albums[index].collectionID
                    {
                        AlbumResultView(
                            viewModel: viewModel,
                            artworkUrl60: artworkUrl60,
                            collectionName: collectionName,
                            artistName: artistName,
                            currency: currency,
                            collectionPrice: collectionPrice,
                            collectionID: collectionID
                        )
                    }
                }
            case .noResult:
                Text("No result found")
            case .loading:
    //            Text("Loading...")
                ProgressView()
                    .progressViewStyle(.circular)
            case .error(let message):
                Text("Error: \(message)")
            }
        }
        .onAppear {
            viewModel.limit = 5
            viewModel.fetchAlbum(term: viewModel.searchTerm)
        }
    }
}

struct AlbumPreviewListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumPreviewListView(viewModel: ViewModel())
    }
}

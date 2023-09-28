import SwiftUI

struct AlbumPreviewListView: View {
    
    @ObservedObject var viewModel: ViewModel
    @State var shouldNav: Bool = false
    
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
    var body: some View {
        VStack {
            HStack {
                Text(AppString.albums[viewModel.language]!)
                Spacer()
                ZStack {
                    
                    Text("\(AppString.more[viewModel.language]!) >")
                        .foregroundColor(.gray)
                        .font(.footnote)
                        .onTapGesture {
                            shouldNav = true
                            
                        }
                    NavigationLink(isActive: $shouldNav) {
                        AlbumFullListView(viewModel: viewModel)
                    } label: {
                        EmptyView()

                    }
                }
            }
            .padding(10)
            
            Divider()
            switch viewModel.albumsFetchStatus {
            case .normal:
                ForEach(filteredList.indices, id: \.self){ index in
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
            case .noResult:
                Text(AppString.noResultFound[viewModel.language]!)
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

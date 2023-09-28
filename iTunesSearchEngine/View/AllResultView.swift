import SwiftUI

struct AllResultView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        ScrollView {
            VStack (spacing: 0) {
                SongPreviewListView(viewModel: viewModel)
                if !viewModel.songs.isEmpty {
                }
            }
            VStack (spacing: 0) {
                AlbumPreviewListView(viewModel: viewModel)
                if !viewModel.albums.isEmpty {
                }
                
            }
            
        }
        .navigationTitle(AppString.results[viewModel.language]!)
    }
}

struct AllResultView_Previews: PreviewProvider {
    static var previews: some View {
        AllResultView(viewModel: ViewModel())
    }
}

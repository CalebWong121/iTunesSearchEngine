import SwiftUI

struct BookMarkView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var column: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView {
            if viewModel.bookMarkList.isEmpty {
                Text(AppString.noBookMark[viewModel.language]!)
            } else {
                LazyVGrid(columns: column) {
                    ForEach(viewModel.bookMarkList.indices, id: \.self){ index in
                        SongResultView(
                            viewModel: viewModel,
                            artworkUrl100: viewModel.bookMarkList[index].artworkUrl100!,
                            trackName: viewModel.bookMarkList[index].trackName!,
                            artistName: viewModel.bookMarkList[index].artistName!,
                            currency: viewModel.bookMarkList[index].currency!,
                            trackPrice: viewModel.bookMarkList[index].trackPrice!,
                            artistID: viewModel.bookMarkList[index].artistID!,
                            trackID: viewModel.bookMarkList[index].trackID!,
                            previewURL: viewModel.bookMarkList[index].previewURL!,
                            bookMark: { viewModel.bookMark(song: viewModel.bookMarkList[index]) }
                        )
                    }
                }
            }
        }
        .navigationTitle(AppString.bookMark[viewModel.language]!)
    }
}

struct BookMarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookMarkView(viewModel: ViewModel())
    }
}

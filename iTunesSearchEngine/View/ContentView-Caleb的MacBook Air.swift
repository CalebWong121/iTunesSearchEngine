import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color("TextFieldGray"))
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField(
                            "Search",
                            text: $viewModel.searchTerm,
                            onCommit: {
                                viewModel.fetchSong(term: viewModel.searchTerm)
                                viewModel.fetchAlbum(term: viewModel.searchTerm)
                            }
                        )
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                        Spacer()
                        if !viewModel.searchTerm.isEmpty {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .onTapGesture {
                                    viewModel.searchTerm = ""
                                }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .frame(height: 40)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .onAppear {
                    viewModel.limit = 5
                    viewModel.fetchSong(term: viewModel.searchTerm)
                    viewModel.fetchAlbum(term: viewModel.searchTerm)
                }
                ScrollView {
                    VStack (spacing: 0) {
                        if !viewModel.songs.isEmpty {
                            SongPreviewListView(viewModel: viewModel)
                        }
                    }
                    VStack (spacing: 0) {
                        if !viewModel.albums.isEmpty {
                            AlbumPreviewListView(viewModel: viewModel)
                        }
                        
                    }
                    
                }
                
            }
            .navigationTitle("iTunes Search Engine")

        }
        .navigationViewStyle(.automatic)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

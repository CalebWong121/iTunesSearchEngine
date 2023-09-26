import Foundation

class ViewModel: ObservableObject {
    var apiManager: APIManager = APIManager()
    @Published var searchTerm: String = ""
    var limit: Int? = 5
    var offset: Int? = 0
    @Published var fetchStatus: FetchStatus = .normal
    @Published var albums: [Album] = []
    @Published var songs: [Song] = []
    
    func fetchAlbum(term: String? = nil, id: Int? = nil){
//        guard let url = URL(string: "https://itunes.apple.com/search?term=jackjohnson&entity=album&limit=5") else { return }
//        guard !searchTerm.isEmpty else { return }
//        guard fetchStatus == .normal || fetchStatus == .noResult else { return }
        
        fetchStatus = .loading
        
        apiManager.fetch(type: AlbumResult.self, url: apiManager.getURL(term: term, id: id, entity: .album, limit: limit, offset: offset)) { result in
            DispatchQueue.main.asyncAfter (deadline: .now() + 1) {
                switch result {
                case .success(let result):
                    if result.resultCount != 0 {
                        self.albums = result.results
                        self.fetchStatus = .normal
                    } else {
                        self.fetchStatus = .noResult
                    }
                case .failure(let error):
                    print(error)
//                    self.fetchStatus = .error("Fetch error: \(error)")
                    self.fetchStatus = .normal

                }
            }
        }
        
    }
    func fetchSong(term: String? = nil, id: Int? = nil){
//        guard let url = URL(string: "https://itunes.apple.com/search?term=jackjohnson&entity=album&limit=5") else { return }
//        guard !searchTerm.isEmpty else { return }
//        guard fetchStatus == .normal || fetchStatus == .noResult else { return }
        
        fetchStatus = .loading
        
        apiManager.fetch(type: SongResult.self, url: apiManager.getURL(term: term, id: id, entity: .song, limit: limit, offset: offset)) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    if result.resultCount != 0 {
                        self.songs = result.results
                        self.fetchStatus = .normal
                    } else {
                        self.fetchStatus = .noResult
                    }
                case .failure(let error):
                    print(error)
//                    self.fetchStatus = .error("Fetch error: \(error)")
                    self.fetchStatus = .normal
                }
            }
        }
    }
    

    
    
    
    
}



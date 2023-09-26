import Foundation

class ViewModel: ObservableObject {
    var apiManager: APIManager = APIManager()
    @Published var searchTerm: String = ""
    var limit: Int? = 5
    var offset: Int? = 0
    @Published var fetchStatus: FetchStatus = .normal
    
    var nestedAlbums: NestedAlbums = NestedAlbums()
    var nestedSongs: NestedSongs = NestedSongs()
    var albums: [Album] {
        return getAlbums(node: nestedAlbums)
    }
    var songs: [Song] {
        return getSongs(node: nestedSongs)
    }
    
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
//                        self.albums = result.results
                        self.addAlbums(albums: result.results, node: self.nestedAlbums)
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
//                        self.songs = result.results
                        self.addSongs(songs: result.results, node: self.nestedSongs)
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
    
    func getAlbums(node: NestedAlbums) -> [Album] {
        if node.child == nil {
            return node.albums
        } else {
            if node.child!.child == nil {
                return node.albums
            } else {
                return getAlbums(node: node.child!)
            }
        }
    }
    
    func addAlbums(albums: [Album], node: NestedAlbums){
        
        if node.child == nil {
            node.albums = albums
            node.child = NestedAlbums()
        } else {
            addAlbums(albums: albums, node: node.child!)
        }
    }
    
    func removeAlbums(node: NestedAlbums){
        if node.child == nil {
            nestedAlbums = NestedAlbums()
        } else {
            if node.child!.child == nil {
                node.child = NestedAlbums()
            } else {
                removeAlbums(node: node.child!)
            }
        }
    }
    
    func getSongs(node: NestedSongs) -> [Song] {
        if node.child == nil {
            return node.songs
        } else {
            if node.child!.child == nil {
                return node.songs
            } else {
                return getSongs(node: node.child!)
            }
        }
    }
    
    func addSongs(songs: [Song], node: NestedSongs){
        
        if node.child == nil {
            node.songs = songs
            node.child = NestedSongs()
        } else {
            addSongs(songs: songs, node: node.child!)
        }
    }
    
    func removeSongs(node: NestedSongs){
        if node.child == nil {
            nestedSongs = NestedSongs()
        } else {
            if node.child!.child == nil {
                node.child = NestedSongs()
            } else {
                removeSongs(node: node.child!)
            }
        }
    }
    
    
    
    
}



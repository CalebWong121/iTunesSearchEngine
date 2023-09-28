import Foundation
import SwiftUI
import AVKit
import AVFoundation

class ViewModel: ObservableObject {
    var apiManager: APIManager = APIManager()
    @Published var searchTerm: String = ""
    var limit: Int? = 5
    var offset: Int? = 0
    @Published var albumsFetchStatus: FetchStatus = .normal
    @Published var songsFetchStatus: FetchStatus = .normal
    @Published var albums: [Album] = []
    @Published var songs: [Song] = []
    @AppStorage("bookMarkList") var bookMarkList: [Song] = []
    @AppStorage("searchHistory") var searchHistory: [String] = []
    @Published var country: Country = .us
    @Published var testArray: [String] = []

    @AppStorage("language") var language: Language = .chi
    
    func fetchAlbum(term: String? = nil, id: Int? = nil){
        guard albumsFetchStatus == .normal || albumsFetchStatus == .noResult else { return }
        print("fetchAlbum")
        albumsFetchStatus = .loading
        
        apiManager.fetch(type: AlbumResult.self, url: apiManager.getURL(term: term, id: id, entity: .album, limit: limit, offset: offset, country: country)) { result in
            DispatchQueue.main.asyncAfter (deadline: .now() + 1) {
                switch result {
                case .success(let result):
                    if result.resultCount != 0 {
                        self.albums = result.results
                        self.albumsFetchStatus = .normal
                    } else {
                        self.albumsFetchStatus = .noResult
                    }
                case .failure(let error):
                    print(error)
                    self.albumsFetchStatus = .normal

                }
            }
        }
        
    }
    func fetchSong(term: String? = nil, id: Int? = nil){
        guard songsFetchStatus == .normal || songsFetchStatus == .noResult else { return }
        print("fetchSong")
        songsFetchStatus = .loading
        
        apiManager.fetch(type: SongResult.self, url: apiManager.getURL(term: term, id: id, entity: .song, limit: limit, offset: offset, country: country)) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    if result.resultCount != 0 {
                        self.songs = result.results
                        self.songsFetchStatus = .normal
                    } else {
                        self.songsFetchStatus = .noResult
                    }
                case .failure(let error):
                    print(error)
                    self.songsFetchStatus = .normal
                }
            }
        }
    }
    
    func bookMark(song: Song){
        let list = bookMarkList.map({$0.trackID})
        if list.contains(song.trackID){
            bookMarkList.removeAll(where: {$0.trackID == song.trackID})
        } else {
            bookMarkList.append(song)
        }
        
    }
    
    func getCountryString(country: Country) -> String {
        switch country {
        case .us:
            return AppString.us[language]!
        case .ca:
            return AppString.ca[language]!
        case .jp:
            return AppString.jp[language]!
        }
    }
    
    private var player: AVPlayer?
    @Published var audioTrackID: Int = 0
    
    func playAudio(from url: URL, for trackID: Int) {
        audioTrackID = trackID
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
    }
    
    func stopAudio() {
        audioTrackID = 0
        player?.pause()
        player = nil
    }
    
}

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else { return nil }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}


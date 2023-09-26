import Foundation

// MARK: - AlbumResult
struct AlbumResult: Codable {
    let resultCount: Int
    let results: [Album]
}

// MARK: - Album
struct Album: Codable, Identifiable {
    let id = UUID()
    let wrapperType, collectionType: String?
    let artistID, collectionID: Int?
    let amgArtistID: Int?
    let artistName, collectionName, collectionCensoredName: String?
    let artistViewURL: String?
    let collectionViewURL: String?
    let artworkUrl60, artworkUrl100: String?
    let collectionPrice: Double?
    let collectionExplicitness: String?
    let trackCount: Int?
    let copyright: String?
    let country, currency: String?
    let releaseDate: String?
    let primaryGenreName: String?

    enum CodingKeys: String, CodingKey {
        case wrapperType, collectionType
        case artistID = "artistId"
        case collectionID = "collectionId"
        case amgArtistID = "amgArtistId"
        case artistName, collectionName, collectionCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case artworkUrl60, artworkUrl100, collectionPrice, collectionExplicitness, trackCount, copyright, country, currency, releaseDate, primaryGenreName
    }
}

// MARK: - NestedAlbums
class NestedAlbums {
    var albums: [Album] = []
    var child: NestedAlbums? = nil
}

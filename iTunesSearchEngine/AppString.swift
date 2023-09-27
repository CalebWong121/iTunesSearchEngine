import Foundation

enum Language: String, CaseIterable, Identifiable {
    case eng = "English"
    case chi = "繁體中文"

    var id: String { self.rawValue }
}

struct AppString {
    static let search: [Language: String] = [.eng: "Search", .chi: "搜尋"]
    static let filterByCountry: [Language: String] = [.eng: "Filter by country", .chi: "篩選國家"]
    static let bookMark: [Language: String] = [.eng: "Book mark", .chi: "書籤"]
    static let searchHistory: [Language: String] = [.eng: "Search history", .chi: "搜尋紀錄"]
    static let results: [Language: String] = [.eng: "Results", .chi: "結果"]
    static let songs: [Language: String] = [.eng: "Songs", .chi: "單曲"]
    static let albums: [Language: String] = [.eng: "Albums", .chi: "專輯"]
    static let more: [Language: String] = [.eng: "More", .chi: "更多"]
    static let resultsFound: [Language: String] = [.eng: "results found", .chi: "項搜尋結果"]
    static let page: [Language: String] = [.eng: "Page", .chi: "頁"]
    static let noResultFound: [Language: String] = [.eng: "No result found", .chi: "找不到搜尋結果"]
    static let noBookMark: [Language: String] = [.eng: "There is no book marked song now", .chi: "找不到已加入書籤的單曲"]
    static let us: [Language: String] = [.eng: "United States of America", .chi: "美國"]
    static let ca: [Language: String] = [.eng: "Canada", .chi: "加拿大"]
    static let jp: [Language: String] = [.eng: "Japan", .chi: "日本"]
    
}

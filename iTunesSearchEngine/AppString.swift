import Foundation

enum Language: String, CaseIterable, Identifiable {
    case eng = "English"
    case chiT = "繁體中文"
    case chiS = "简体中文"

    var id: String { self.rawValue }
}

struct AppString {
    static let search: [Language: String] = [.eng: "Search", .chiT: "搜尋", .chiS: "搜寻"]
    static let filterByCountry: [Language: String] = [.eng: "Filter by country", .chiT: "篩選國家", .chiS: "筛选国家"]
    static let bookMark: [Language: String] = [.eng: "Book mark", .chiT: "書籤", .chiS: "书籤"]
    static let searchHistory: [Language: String] = [.eng: "Search history", .chiT: "搜尋紀錄", .chiS: "搜寻纪录"]
    static let results: [Language: String] = [.eng: "Results", .chiT: "結果", .chiS: "结果"]
    static let songs: [Language: String] = [.eng: "Songs", .chiT: "單曲", .chiS: "单曲"]
    static let albums: [Language: String] = [.eng: "Albums", .chiT: "專輯", .chiS: "专辑"]
    static let more: [Language: String] = [.eng: "More", .chiT: "更多", .chiS: "更多"]
    static let resultsFound: [Language: String] = [.eng: "results found", .chiT: "項搜尋結果", .chiS: "项搜寻结果"]
    static let page: [Language: String] = [.eng: "Page", .chiT: "頁", .chiS: "页"]
    static let noResultFound: [Language: String] = [.eng: "No result found", .chiT: "找不到搜尋結果", .chiS: "找不到搜寻结果"]
    static let noBookMark: [Language: String] = [.eng: "There is no book marked song now", .chiT: "找不到已加入書籤的單曲", .chiS: "找不到已加入书籤的单曲"]
    static let us: [Language: String] = [.eng: "United States of America", .chiT: "美國", .chiS: "美国"]
    static let ca: [Language: String] = [.eng: "Canada", .chiT: "加拿大", .chiS: "加拿大"]
    static let jp: [Language: String] = [.eng: "Japan", .chiT: "日本", .chiS: "日本"]
    
}

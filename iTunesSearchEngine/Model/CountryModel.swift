import Foundation

enum Country: String, Identifiable, CaseIterable {
    case us
    case ca
    case jp
    
    var id: String { self.rawValue }
}

import Foundation
import AVKit
import AVFoundation

class AudioViewModel: ObservableObject {
    private var player: AVPlayer?
    
    func playAudio(from url: URL) {
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
    }
    
    func stopAudio() {
        player?.pause()
        player = nil
    }
}

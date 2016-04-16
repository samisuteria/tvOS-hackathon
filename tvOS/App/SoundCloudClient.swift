import Foundation
import NPAudioStream

class SoundCloudClient: NSObject {
    
    static let sharedClient = SoundCloudClient()
    
    private var currentIndex = 0
    private var tracks = [Track]()
    
    private let SoundCloud = (
        clientID: "4f42baeb1a55ace1b73df9b19ba08107",
        clientSecret: "e1accb5ad7f54ffd70d30b715a39e19a"
    )
    
    let audioStream = NPAudioStream()
    
    override init() {
        super.init()
        audioStream.delegate = self
    }
    
    private func createURL(soundcloudTrackID: String) -> NSURL? {
        let urlString = "https://api.soundcloud.com/tracks/\(soundcloudTrackID)/stream?client_id=\(SoundCloud.clientID)"
        return NSURL(string: urlString)
    }
}

extension SoundCloudClient: NPAudioStreamDelegate {
    func audioStream(audioStream: NPAudioStream!, didBeginPlaybackForTrackAtIndex index: Int) {
        currentIndex = index
    }
}

//Public API

extension SoundCloudClient {
    
    func addTrack(track: Track) {
        tracks.append(track)
        if let url = createURL(track.soundcloudID) {
            audioStream.urls.append(url)
        }
    }
    
    func addTracks(tracks: [Track]) {
        tracks.forEach { (track: Track) in
            addTrack(track)
        }
    }
    
    func play() {
        if currentIndex < tracks.count {
            audioStream.selectIndexForPlayback(currentIndex)
        }
    }
}

//Test Tracks
//api.soundcloud.com/tracks/221228549
//api.soundcloud.com/tracks/209315983 //shia the tank engine
//api.soundcloud.com/tracks/121879277

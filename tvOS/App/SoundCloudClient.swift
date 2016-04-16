import Foundation
import NPAudioStream

class SoundCloudClient: NSObject {
    
    static let sharedClient = SoundCloudClient()
    
    private var tracks = [String]()
    
    private let SoundCloud = (
        clientID: "4f42baeb1a55ace1b73df9b19ba08107",
        clientSecret: "e1accb5ad7f54ffd70d30b715a39e19a"
    )
    
    let audioStream = NPAudioStream()
    
    override init() {
        super.init()
        audioStream.delegate = self
        
        addTrack("209315983")
    }
    
    private func createURL(trackID: String) -> NSURL? {
        let urlString = "https://api.soundcloud.com/tracks/\(trackID)/stream?client_id=\(SoundCloud.clientID)"
        return NSURL(string: urlString)
    }
    
    
}

extension SoundCloudClient: NPAudioStreamDelegate {
    
}

//Public API

extension SoundCloudClient {
    func addTrack(trackID: String){
        tracks.append(trackID)
    }
    
    func playNext() {
        let trackID = tracks.removeFirst()
        if let url = createURL(trackID) {
            audioStream.urls = [url]
            audioStream.selectIndexForPlayback(0)
        }
    }
}

//Test Tracks
//api.soundcloud.com/tracks/221228549
//api.soundcloud.com/tracks/209315983 //shia the tank engine
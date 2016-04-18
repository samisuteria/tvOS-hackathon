import Foundation
import NPAudioStream
import Alamofire

class SoundCloudClient: NSObject {
    
    static let sharedClient = SoundCloudClient()
    
    private var currentIndex = 0
    private var tracks = [Track]()
    var session: Session!
    
    private let SoundCloud = (
        clientID: "4f42baeb1a55ace1b73df9b19ba08107",
        clientSecret: "e1accb5ad7f54ffd70d30b715a39e19a"
    )
    
    let audioStream = NPAudioStream()
    
    override init() {
        super.init()
        audioStream.delegate = self
        session = Session()
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
        
        TrackManager.addTrackToQueue(track)
        
        if let url = createURL(track.soundcloudID) {
            tracks.append(track)
            if audioStream.urls == nil {
                audioStream.urls = [url]
            } else {
                audioStream.urls.append(url)
            }
        } else {
            print("error adding track to the list: \(track)")
        }
    }
    
    func addTracks(tracks: [Track]) {
        tracks.forEach { (track: Track) in
            addTrack(track)
        }
    }
    
    func play() {
        audioStream.play()
    }
    
    func pause() {
        audioStream.pause()
    }
	
    func addID(soundcloudTrackID: String) {
        
        let url = "https://api.soundcloud.com/tracks/\(soundcloudTrackID)?client_id=\(SoundCloud.clientID)"
        Alamofire.request(.GET, url).response { (request: NSURLRequest?, response: NSHTTPURLResponse?, data: NSData?, error: NSError?) in
            
            guard
                let data = data,
                let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
                let trackData = json as? [String: AnyObject]
                else {
                    print("boo")
                    return
            }
            
            if
                let id = trackData["id"] as? Int,
                let title = trackData["title"] as? String,
                let user = trackData["user"] as? [String: AnyObject],
                let username = user["username"] as? String,
                let streamable = trackData["streamable"] as? Bool where streamable == true
            {
                let track = Track(title: title,
                    artist: username,
                    soundcloudID: String(id),
                    URL: self.createURL(String(id))!,
                    userID: "anon")
                
                self.addTrack(track)
            }
        }
    }
}

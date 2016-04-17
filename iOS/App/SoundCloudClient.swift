import Foundation
import Alamofire

class SoundCloudClient {
    
    static let sharedClient = SoundCloudClient()
    
    private let SoundCloud = (
        clientID: "4f42baeb1a55ace1b73df9b19ba08107",
        clientSecret: "e1accb5ad7f54ffd70d30b715a39e19a"
    )
    
    func search(query: String, completion: (tracks: [SoundCloudTrackModel]?) -> ()) {
        
        let encodedQuery = query.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        let url = "https://api.soundcloud.com/tracks?client_id=\(SoundCloud.clientID)&q=\(encodedQuery)"
        
        Alamofire.request(.GET, url)
            .response { (request: NSURLRequest?, response: NSHTTPURLResponse?, data: NSData?, error: NSError?) in
                
                guard
                    let data = data,
                    let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
                    let tracksData = json as? [[String: AnyObject]]
                    else {
                        print("boo")
                        completion(tracks: nil)
                        return
                }
                
                print(tracksData.count)
                
                var tracks = [SoundCloudTrackModel]()
                
                tracksData.forEach({ (trackData: [String : AnyObject]) in
                    
                    if
                        let artworkURLString = trackData["artwork_url"] as? String,
                        let artworkURL = NSURL(string: artworkURLString),
                        let id = trackData["id"] as? Int,
                        let tags = trackData["tag_list"] as? String,
                        let title = trackData["title"] as? String,
                        let user = trackData["user"] as? [String: AnyObject],
                        let username = user["username"] as? String,
                        let streamable = trackData["streamable"] as? Bool where streamable == true
                    {
                        let track = SoundCloudTrackModel(artworkURL: artworkURL,
                            id: String(id),
                            tags: tags,
                            title: title,
                            username: username)
                        tracks.append(track)
                    }
                })
                
                
                
                
            
                completion(tracks: tracks)
        }
        
        
        
        
        
    }
    
    
}
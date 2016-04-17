import Foundation

class SoundCloudClient {
    
    static let sharedClient = SoundCloudClient()
    
    private let SoundCloud = (
        clientID: "4f42baeb1a55ace1b73df9b19ba08107",
        clientSecret: "e1accb5ad7f54ffd70d30b715a39e19a"
    )
    
    func search(title: String, artist: String) {
        
        let url = NSURL(string:"https://api.soundcloud.com/tracks?client_id=\(SoundCloud.clientID)")!
        let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(NSURLRequest(URL: url)) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            
            guard let data = data,
                  let json = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
            else {
                print("can't serialize data")
                return
            }
            
            print(json)
            
            print("AsdasD")
        }
        dataTask.resume()
        
    }
    
    
}
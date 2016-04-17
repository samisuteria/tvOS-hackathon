import UIKit
import SnapKit

class SoundCloudSearchViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .grayColor()
        
        SoundCloudClient.sharedClient.search("childish") { (tracks) in
            if let tracks = tracks {
                print(tracks.count)
            }
        }
        
    }

   
    

    

}

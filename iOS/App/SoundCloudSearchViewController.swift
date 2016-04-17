import UIKit
import SnapKit

class SoundCloudSearchViewController: UIViewController {
    
    var tracks = [SoundCloudTrackModel]()
    let tableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        view.backgroundColor = .grayColor()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    private func setupViews() {
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clearColor()
        
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        

        
    }

   
    

    

}

extension SoundCloudSearchViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let query = searchController.searchBar.text ?? ""
        
        SoundCloudClient.sharedClient.search(query) { (tracks) in
            if let tracks = tracks {
                self.tracks = tracks
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
        }
    }
}

extension SoundCloudSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = tracks[indexPath.row].title
        
        return cell
    }
}

import UIKit
import SnapKit

class RoomListViewController: UIViewController {
    
    let serverManager = ServerManager.sharedManager
    
    let tableView = UITableView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        serverManager.roomlistDelegate = self
    }
    
    //MARK: - Setup
    
    private func setupViews() {
        
        title = "Join a Room"
        view.backgroundColor = .grayColor()
        
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

extension RoomListViewController: ServerManagerRoomListDelegate {
    func serverManagerUpdatedRoomList() {
        dispatch_async(dispatch_get_main_queue()) { 
            self.tableView.reloadData()
        }
    }
}


extension RoomListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serverManager.roomnames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = serverManager.roomnames[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        serverManager.joinRoom(serverManager.roomnames[indexPath.row])
    }
}

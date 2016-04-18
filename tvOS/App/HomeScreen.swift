import UIKit
import AVKit

class HomeScreen: UIViewController {
	
	private var mainView: UIView
	private var songList: UITableView
	private var trackPlayerView: TrackPlayerView
	private let backgroundImageView: UIImageView
	private let sessionIDView: UIView
	private var songListSwipeLeftGesture = UISwipeGestureRecognizer()
	private var sessionIDLabel = UILabel(frame: CGRect.zero)
	
	var preferredFocusedViewLeavingSongList: UIView?
	override var preferredFocusedView: UIView? {
		let preferredView = preferredFocusedViewLeavingSongList
		return preferredView
	}
	
	private struct Constants {
		static let headerViewHeight: CGFloat = 90
		static let trackPlayerHeight: CGFloat = 200
		static let trackPlayerSpacerWidthRatio: CGFloat = 1 / 10
		static let mainViewWidthRatio: CGFloat = 3 / 4
		static let tableViewWidthRatio: CGFloat = 1 / 4
		static let cellReuseID = "songListCellID"
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
		mainView = UIView(frame: CGRect.zero)
		sessionIDView = UIView(frame: CGRect.zero)
		songList = UITableView(frame: CGRect.zero)
		backgroundImageView = UIImageView(image: UIImage(named: "beautifulWaterBackground"))
		
		trackPlayerView = TrackPlayerView(frame: CGRect.zero)
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		preferredFocusedViewLeavingSongList = trackPlayerView.playStopButton
		songListSwipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeftSongList))
		songListSwipeLeftGesture.direction = .Left
		songList.addGestureRecognizer(songListSwipeLeftGesture)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        view.backgroundColor = UIColor.whiteColor()
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(trackQueueModified), name: "AddTrackToQueue", object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(trackQueueModified), name: "RemoveTrackFromQueue", object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(trackQueueModified), name: "UpdateQueue", object: nil)
		// FIXME: hardcode until can grab from server
//		let track = Track(title: "Track Title 1", artist: "Fake Artist 1", soundcloudID: "256733104", URL: NSURL(string: "https://api.soundcloud.com/tracks/256733104/stream?client_id=4f42baeb1a55ace1b73df9b19ba08107")!, userID: "123")
//		let track2 = Track(title: "Track Title 2", artist: "Fake Artist 2", soundcloudID: "209315983", URL: NSURL(string: "https://api.soundcloud.com/tracks/209315983/stream?client_id=4f42baeb1a55ace1b73df9b19ba08107")!, userID: "123")
//		let track3 = Track(title: "Track Title 3", artist: "Fake Artist 3", soundcloudID: "209315983", URL: NSURL(string: "https://api.soundcloud.com/tracks/209315983/stream?client_id=4f42baeb1a55ace1b73df9b19ba08107")!, userID: "123")
//		let track4 = Track(title: "Track Title 4", artist: "Fake Artist 4", soundcloudID: "209315983", URL: NSURL(string: "https://api.soundcloud.com/tracks/209315983/stream?client_id=4f42baeb1a55ace1b73df9b19ba08107")!, userID: "123")
//		TrackManager.addTracksToQueue([track, track2, track3, track4])
////		TrackManager.addTracksToQueue([track, track2, track, track, track, track, track, track, track, track, track, track, track, track, track, track])
		configureSubviews()
		sessionIDView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
		sessionIDLabel.textColor = UIColor.whiteColor()
		sessionIDLabel.textAlignment = .Center
		sessionIDLabel.font = UIFont(name: "Avenir-Medium", size: 30.0)
		sessionIDView.addSubview(sessionIDLabel)
		mainView.addSubview(sessionIDView)
		
		ServerManager.sharedManager.delegate = self
		songList.separatorInset = UIEdgeInsetsZero
		songList.layoutMargins = UIEdgeInsetsZero
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		sessionIDLabel.text = ""
		mainView.frame = CGRect(x: 0, y: 0, width: ceil(view.bounds.width * Constants.mainViewWidthRatio), height: view.bounds.size.height)
		songList.frame = CGRect(x: mainView.bounds.maxX, y: 0, width: ceil(view.bounds.width * Constants.tableViewWidthRatio), height: view.bounds.size.height)
		
		let trackPlayerSpacing = floor(mainView.bounds.width * Constants.trackPlayerSpacerWidthRatio)
		sessionIDView.frame = CGRect(x: trackPlayerSpacing, y: 0, width: ceil(mainView.bounds.width - (2 * trackPlayerSpacing)), height: 100)
		sessionIDLabel.frame = CGRect(x: 0, y: 0, width: ceil(mainView.bounds.width - (2 * trackPlayerSpacing)), height: 100)
		backgroundImageView.frame = view.frame
		
		
		trackPlayerView.frame = CGRect(x: trackPlayerSpacing, y: view.bounds.maxY - Constants.trackPlayerHeight, width: ceil(mainView.bounds.width - (2 * trackPlayerSpacing)), height: Constants.trackPlayerHeight)
	}
	
	private func configureSubviews() {
		backgroundImageView.contentMode = .ScaleAspectFill
		backgroundImageView.alpha = 0.8
		view.addSubview(backgroundImageView)
		mainView.backgroundColor = UIColor.clearColor()
		
		songList.delegate = self
		songList.dataSource = self
		songList.backgroundColor = UIColor.clearColor()
		songList.registerClass(SongListItem.self, forCellReuseIdentifier: Constants.cellReuseID)

		mainView.addSubview(trackPlayerView)
		view.addSubview(mainView)
		view.addSubview(songList)
	}
	
	@objc private func trackQueueModified() {
		songList.reloadData()
	}
	
	// MARK: - Actions
	
	@objc private func swipedLeftSongList() {
		preferredFocusedViewLeavingSongList = trackPlayerView.skipButton
		setNeedsFocusUpdate()
		updateFocusIfNeeded()
	}
	
}

extension HomeScreen: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let count = TrackManager.currentQueue().count
		return count
	}
	
	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		if section == 0 {
			return Constants.headerViewHeight
		}
		return 0
	}
	
	func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		if TrackManager.currentQueue().count == 0 {
			return 80
		}
		return 0
	}
	
	func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let footerView = UIView(frame: CGRect(x: 0, y: 0, width: ceil(view.bounds.width * Constants.tableViewWidthRatio), height: 80))
		let label = UILabel(frame: footerView.frame)
		label.text = "No Tracks Queued"
		label.font = UIFont(name: "Avenir-Medium", size: 20.0)
		label.textAlignment = .Center
		footerView.addSubview(label)
		footerView.backgroundColor = UIColor.whiteColor()
		return footerView
	}
	
	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		if section == 0 {
			let headerFrame = CGRectMake(ceil(view.bounds.width * Constants.tableViewWidthRatio), 0, ceil(view.bounds.width * Constants.tableViewWidthRatio), Constants.headerViewHeight)
			let headerView = UIView(frame: headerFrame)
			let headerLabelFrame = CGRect(x: 5, y: 5, width: headerFrame.size.width - 10, height: headerFrame.size.height - 10)
			let headerLabel = UILabel(frame: headerLabelFrame)
			
			headerLabel.text = "On Deck".uppercaseString
			headerLabel.textAlignment = .Center
			headerLabel.adjustsFontSizeToFitWidth = true
			headerLabel.font = UIFont(name: "Avenir-Heavy", size: 28.0)
			headerLabel.textColor = UIColor.whiteColor()
			headerView.addSubview(headerLabel)
			headerView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
			return headerView
		}
		return UIView(frame: CGRect.zero)
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		// FIXME: Use automatic height
		return 60
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = songList.dequeueReusableCellWithIdentifier(Constants.cellReuseID, forIndexPath: indexPath) as! SongListItem
		if let title = TrackManager.currentQueue()[indexPath.row]?.title {
			cell.songName = title
		}
		if let artist = TrackManager.currentQueue()[indexPath.row]?.artist {
			cell.songArtist = artist
		}
		cell.layoutMargins = UIEdgeInsetsZero
		cell.preservesSuperviewLayoutMargins = false
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let trackToRemove = TrackManager.currentQueue()[indexPath.row] {
            TrackManager.loadAndPlayTrack(trackToRemove)
        }
	}

}

extension HomeScreen: ServerManagerDelegate {
	func serverManagerAssignedRoom(room: String) {
		sessionIDLabel.text = room
	}
}

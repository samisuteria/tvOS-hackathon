import UIKit

class HomeScreen: UIViewController {
	
	private var mainView: UIView
	private var songList: UITableView
	private var playButton: UIButton
	private var skipButton: UIButton
	private var songName: UILabel
	private var trackPlayer: TrackPlayer
	
	private struct Constants {
		static let trackPlayerHeight: CGFloat = 250
		static let trackPlayerSpacerWidthRatio: CGFloat = 1 / 10
		static let mainViewWidthRatio: CGFloat = 3 / 4
		static let tableViewWidthRatio: CGFloat = 1 / 4
		static let cellReuseID = "songListCellID"
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
		mainView = UIView(frame: CGRect.zero)
		songList = UITableView(frame: CGRect.zero)
		playButton = UIButton(type: .System)
		skipButton = UIButton(type: .System)
		songName = UILabel(frame: CGRect.zero)
		// FIXME: use real url
		let startingURL = NSURL(string: "http://api.soundcloud.com/tracks/209315983")
		trackPlayer = TrackPlayer(frame: CGRect.zero, url: startingURL)
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        view.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.25)
		configureSubviews()
    }
	
	private func configureSubviews() {
		mainView.backgroundColor = UIColor.whiteColor()
		
		songList.delegate = self
		songList.dataSource = self
		songList.backgroundColor = UIColor.grayColor()
		songList.registerClass(SongListItem.self, forCellReuseIdentifier: Constants.cellReuseID)
		songList.rowHeight = UITableViewAutomaticDimension

		mainView.addSubview(trackPlayer)
		view.addSubview(mainView)
		view.addSubview(songList)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		mainView.frame = CGRect(x: 0, y: 0, width: ceil(view.bounds.width * Constants.mainViewWidthRatio), height: view.bounds.size.height)
		songList.frame = CGRect(x: mainView.bounds.maxX, y: 0, width: ceil(view.bounds.width * Constants.tableViewWidthRatio), height: view.bounds.size.height)
		
		let trackPlayerSpacing = floor(mainView.bounds.width * Constants.trackPlayerSpacerWidthRatio)
		trackPlayer.frame = CGRect(x: trackPlayerSpacing, y: view.bounds.maxY - Constants.trackPlayerHeight, width: ceil(mainView.bounds.width - (2 * trackPlayerSpacing)), height: Constants.trackPlayerHeight)
	}
	
}

extension HomeScreen: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// FIXME: Get this info from Sami's shit
		return 10
	}
	
	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		// TODO: Add Header Section
		return UIView(frame: CGRect.zero)
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		// FIXME: Use automatic height
		return 50
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = songList.dequeueReusableCellWithIdentifier(Constants.cellReuseID, forIndexPath: indexPath)
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		print("Selected row at index path \(indexPath)")
	}
	
}
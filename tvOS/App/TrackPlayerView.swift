//
//  TrackPlayerView.swift
//  App
//
//  Created by Carlos Alban on 4/16/16.
//  Copyright © 2016 CGRekt. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class TrackPlayerView: UIView {
	
	struct Constants {
		static let padding: CGFloat = 15
		static let containerHeight: CGFloat = 150
		static let controlButtonSize = CGSize(width:100 ,height: 100)
	}
	
	var playStopButton: UIButton
	var	skipButton: UIButton
	private var songLabel: UILabel
	private var avPlayer: AVPlayer
	private var avPlayerContainer: UIView
	
	// FIXME: temporary bool for stop/play delete after hooking up with track manager
	private var isPlaying: Bool

	
	init(frame: CGRect, songName: String, track: Track) {
		isPlaying = false // FIXME: DELETE after hooked up with track manager
		avPlayerContainer = UIView(frame: CGRect.zero)
		let asset = AVAsset(URL: track.URL)
		let playerItem = AVPlayerItem(asset: asset)
		avPlayer = AVPlayer(playerItem: playerItem)
		songLabel = UILabel(frame: CGRect.zero)
		playStopButton = UIButton(type: .System)
		skipButton = UIButton(type: .System)
		super.init(frame: frame)
		
		backgroundColor = UIColor.purpleColor()
		avPlayerContainer.backgroundColor = UIColor.brownColor()
		playStopButton.backgroundColor = UIColor.cyanColor()
		skipButton.backgroundColor = UIColor.cyanColor()
		
		playStopButton.setImage(UIImage(named: "play2"), forState: .Normal)
		playStopButton.adjustsImageWhenHighlighted = true
		playStopButton.addTarget(self, action: #selector(playStopButtonPressed(_:)), forControlEvents: .PrimaryActionTriggered)
		
		skipButton.setBackgroundImage(UIImage(named: "forward2"), forState: .Normal)
		skipButton.setImage(UIImage(named: "forward2"), forState: .Normal)
		skipButton.adjustsImageWhenHighlighted = true
		skipButton.addTarget(self, action: #selector(trackPlayerViewSkipTrack(_:)), forControlEvents: .PrimaryActionTriggered)
		
		
		songLabel.font = UIFont.systemFontOfSize(30.0)
		songLabel.numberOfLines = 1
		songLabel.textAlignment = .Center
		songLabel.text = songName
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureSubviews() {
		let maxWidth = bounds.width - 2 * Constants.padding
		let songLabelSize = songLabel.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.max))
		
		songLabel.frame.size = songLabelSize
		
		avPlayerContainer.addSubview(playStopButton)
		avPlayerContainer.addSubview(skipButton)
		addSubview(avPlayerContainer)
		addSubview(songLabel)
	}
	
	override func layoutSubviews() {
		configureSubviews()
		avPlayerContainer.frame = CGRect(x: Constants.padding, y: 0, width: ceil(bounds.width - 2 * Constants.padding), height: Constants.containerHeight)
		
		let songLabelYPadding: CGFloat = floor(((bounds.height - avPlayerContainer.bounds.maxY) - ceil(songLabel.bounds.height)) / 2)
		let centerX = floor(bounds.width / 2)
		playStopButton.frame = CGRectMake(centerX - Constants.padding - Constants.controlButtonSize.width, floor((avPlayerContainer.bounds.height - Constants.controlButtonSize.height) / 2) , Constants.controlButtonSize.width, Constants.controlButtonSize.height)
		skipButton.frame = CGRectMake(centerX + Constants.padding, floor((avPlayerContainer.bounds.height - Constants.controlButtonSize.height) / 2) , Constants.controlButtonSize.width, Constants.controlButtonSize.height)
		
		songLabel.frame = CGRect(x: Constants.padding, y: songLabelYPadding + avPlayerContainer.bounds.maxY, width: ceil(bounds.width - 2 * Constants.padding), height: ceil(songLabel.bounds.height))
	}
	
	// MARK: - Actions
	
	@objc private func playStopButtonPressed(sender: AnyObject) {
		
		// FIXME: once track manager is hooked up, use that bool instead of local
		if (isPlaying) {
			trackPlayerViewPauseTrack(sender)
		} else {
			trackPlayerViewPlayTrack(sender)
		}
		isPlaying = !isPlaying
	}
	
	// TODO: hook up with track manager
	private func trackPlayerViewPlayTrack(sender: AnyObject) {
		print("play pressed")
		playStopButton.setImage(UIImage(named: "pause1"), forState: .Normal)
		avPlayer.play()
	}
	
	private func trackPlayerViewPauseTrack(sender: AnyObject) {
		print("pause pressed")
		playStopButton.setImage(UIImage(named: "play2"), forState: .Normal)
		avPlayer.pause()
	}
	
	@objc private func trackPlayerViewSkipTrack(sender: AnyObject) {
		print("pause pressed")
		// TODO: handle skipping
		// Once track is finished skipping, play
		trackPlayerViewPlayTrack(self)
		isPlaying = true
	}

}
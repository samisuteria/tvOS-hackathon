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
	
	private let playImage = UIImage(named: "play")
	private let pauseImage = UIImage(named: "pause")
	private let forwardImage = UIImage(named: "forward")
	private let visualEffectView: UIVisualEffectView
	
	struct Constants {
		static let padding: CGFloat = 15
		static let controlButtonsPadding: CGFloat = 25
		static let containerHeight: CGFloat = 150
		static let controlButtonSize = CGSize(width: 70 ,height: 70)
	}
	
	var playStopButton: UIButton
	var	skipButton: UIButton
	private var songLabel: UILabel
	private var avPlayer: AVPlayer
	private var avPlayerContainer: UIView
	
	// FIXME: temporary bool for stop/play delete after hooking up with track manager
	private var isPlaying: Bool

	
	init(frame: CGRect, songName: String, track: Track) {
		visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
		isPlaying = false // FIXME: DELETE after hooked up with track manager
		avPlayerContainer = UIView(frame: CGRect.zero)
		let asset = AVAsset(URL: track.URL)
		let playerItem = AVPlayerItem(asset: asset)
		avPlayer = AVPlayer(playerItem: playerItem)
		songLabel = UILabel(frame: CGRect.zero)
		playStopButton = UIButton(type: .System)
		skipButton = UIButton(type: .System)
		super.init(frame: frame)
		
		backgroundColor = UIColor.clearColor()
		addSubview(visualEffectView)
		
		avPlayerContainer.backgroundColor = UIColor.clearColor()
		
		playStopButton.setBackgroundImage(playImage, forState: .Normal)
		playStopButton.adjustsImageWhenHighlighted = false
		playStopButton.addTarget(self, action: #selector(playStopButtonPressed(_:)), forControlEvents: .PrimaryActionTriggered)
		
		skipButton.setBackgroundImage(forwardImage, forState: .Normal)
		skipButton.adjustsImageWhenHighlighted = false
		skipButton.addTarget(self, action: #selector(trackPlayerViewSkipTrack(_:)), forControlEvents: .PrimaryActionTriggered)
		
		songLabel.font = UIFont.systemFontOfSize(30.0)
		songLabel.numberOfLines = 1
		songLabel.textAlignment = .Center
		songLabel.text = "Now Playing: \(songName)"
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
		visualEffectView.frame = bounds
		
		songLabel.frame = CGRect(x: Constants.padding, y: Constants.padding, width: ceil(bounds.width - 2 * Constants.padding), height: ceil(songLabel.bounds.height))
		//songLabel.frame = CGRect(x: Constants.padding, y: songLabelYPadding + avPlayerContainer.bounds.maxY, width: ceil(bounds.width - 2 * Constants.padding), height: ceil(songLabel.bounds.height))
		let buttonYPadding: CGFloat = floor(((bounds.height - songLabel.bounds.maxY) - ceil(Constants.controlButtonSize.height)) / 2)
		avPlayerContainer.frame = CGRect(x: Constants.padding, y: Constants.padding + songLabel.bounds.maxY, width: ceil(bounds.width - 2 * Constants.padding), height: Constants.containerHeight)
		
		
		let centerX = floor(bounds.width / 2)
		playStopButton.frame = CGRectMake(centerX - Constants.controlButtonsPadding - Constants.controlButtonSize.width, floor((avPlayerContainer.bounds.height - Constants.controlButtonSize.height) / 2) , Constants.controlButtonSize.width, Constants.controlButtonSize.height)
		skipButton.frame = CGRectMake(centerX + Constants.controlButtonsPadding, floor((avPlayerContainer.bounds.height - Constants.controlButtonSize.height) / 2) , Constants.controlButtonSize.width, Constants.controlButtonSize.height)
		
		
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
		playStopButton.setBackgroundImage(pauseImage, forState: .Normal)
		playStopButton.setBackgroundImage(pauseImage, forState: .Focused)
		
		avPlayer.play()
	}
	
	private func trackPlayerViewPauseTrack(sender: AnyObject) {
		print("pause pressed")
		playStopButton.setBackgroundImage(playImage, forState: .Normal)
		playStopButton.setBackgroundImage(playImage, forState: .Focused)
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
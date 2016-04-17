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
		static let controlButtonsPadding: CGFloat = 25
		static let containerHeight: CGFloat = 150
		static let controlButtonSize = CGSize(width: 70 ,height: 70)
	}
	
	private let playImage = UIImage(named: "play")
	private let pauseImage = UIImage(named: "pause")
	private let forwardImage = UIImage(named: "forward")
	private let visualEffectView: UIVisualEffectView
	
	private var songLabel: UILabel
	private var avPlayerContainer: UIView
	var playStopButton: UIButton
	var	skipButton: UIButton
	
	
	override init(frame: CGRect) {
		visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
		avPlayerContainer = UIView(frame: CGRect.zero)
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
		updateTrackLabel()
		visualEffectView.frame = bounds
		
		songLabel.frame = CGRect(x: Constants.padding, y: Constants.padding, width: ceil(bounds.width - 2 * Constants.padding), height: ceil(songLabel.bounds.height))
		//songLabel.frame = CGRect(x: Constants.padding, y: songLabelYPadding + avPlayerContainer.bounds.maxY, width: ceil(bounds.width - 2 * Constants.padding), height: ceil(songLabel.bounds.height))
		avPlayerContainer.frame = CGRect(x: Constants.padding, y: Constants.padding + songLabel.bounds.maxY, width: ceil(bounds.width - 2 * Constants.padding), height: Constants.containerHeight)
		
		
		let centerX = floor(bounds.width / 2)
		playStopButton.frame = CGRectMake(centerX - Constants.controlButtonsPadding - Constants.controlButtonSize.width, floor((avPlayerContainer.bounds.height - Constants.controlButtonSize.height) / 2) , Constants.controlButtonSize.width, Constants.controlButtonSize.height)
		skipButton.frame = CGRectMake(centerX + Constants.controlButtonsPadding, floor((avPlayerContainer.bounds.height - Constants.controlButtonSize.height) / 2) , Constants.controlButtonSize.width, Constants.controlButtonSize.height)
		
		
	}
	
	private func updateTrackLabel() {
		if let currentTrack = TrackManager.currentTrack() {
			songLabel.text = "Now Playing: \(currentTrack.artist) - \(currentTrack.title)"
		} else {
			songLabel.text = "Now Playing: ...track queue is empty"
		}
	}
	
	// MARK: - Actions
	
	@objc private func playStopButtonPressed(sender: AnyObject) {
		updateTrackLabel()
		if (TrackManager.isPlayingTrack) {
			trackPlayerViewPauseTrack(sender)
		} else {
			trackPlayerViewPlayTrack(sender)
		}
	}
	
	// TODO: update the focused images
	private func trackPlayerViewPlayTrack(sender: AnyObject) {
		TrackManager.playCurrentTrack()
		guard TrackManager.isPlayingTrack else { return }
		playStopButton.setBackgroundImage(pauseImage, forState: .Normal)
		playStopButton.setBackgroundImage(pauseImage, forState: .Focused)
	}
	
	private func trackPlayerViewPauseTrack(sender: AnyObject) {
		TrackManager.pauseCurrentTrack()
		guard !TrackManager.isPlayingTrack else { return }
		playStopButton.setBackgroundImage(playImage, forState: .Normal)
		playStopButton.setBackgroundImage(playImage, forState: .Focused)
	}
	
	@objc private func trackPlayerViewSkipTrack(sender: AnyObject) {
		TrackManager.skipCurrentTrack()
		updateTrackLabel()
		if TrackManager.isPlayingTrack {
			playStopButton.setBackgroundImage(pauseImage, forState: .Normal)
			playStopButton.setBackgroundImage(pauseImage, forState: .Focused)
		} else {
			playStopButton.setBackgroundImage(playImage, forState: .Normal)
			playStopButton.setBackgroundImage(playImage, forState: .Focused)
		}
	}

}
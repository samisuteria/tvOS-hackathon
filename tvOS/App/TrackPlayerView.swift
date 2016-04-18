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
		static let controlButtonsPadding: CGFloat = 80
		static let containerHeight: CGFloat = 150
		static let controlButtonSize = CGSize(width: 60 ,height: 60)
	}
	
	private let playImage = UIImage(named: "play")
	private let pauseImage = UIImage(named: "pause")
	private let forwardImage = UIImage(named: "forward")

    private let playImageWhite = UIImage(named: "play-white")
    private let pauseImageWhite = UIImage(named: "pause-white")
    private let forwardImageWhite = UIImage(named: "forward-white")
	private let visualEffectView: UIVisualEffectView
	
	private var songLabel: UILabel
	private var avPlayerContainer: UIView
	var playStopButton: UIButton
	var	skipButton: UIButton
	
	
	override init(frame: CGRect) {
		visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
		avPlayerContainer = UIView(frame: CGRect.zero)
		songLabel = UILabel(frame: CGRect.zero)
		playStopButton = UIButton(type: .Custom)
		skipButton = UIButton(type: .Custom)
		super.init(frame: frame)
		
		backgroundColor = UIColor.clearColor()
		addSubview(visualEffectView)
		
		avPlayerContainer.backgroundColor = UIColor.clearColor()
		playStopButton.backgroundColor = UIColor.clearColor()
		skipButton.backgroundColor = UIColor.clearColor()
		
		let focusedColor = UIColor.whiteColor()
		playStopButton.setBackgroundImage(playImage, forState: .Normal)
        playStopButton.setBackgroundImage(playImageWhite, forState: .Focused)
		playStopButton.tintColor = focusedColor
		playStopButton.adjustsImageWhenHighlighted = false
		playStopButton.addTarget(self, action: #selector(playStopButtonPressed(_:)), forControlEvents: .PrimaryActionTriggered)
		
		skipButton.setBackgroundImage(forwardImage, forState: .Normal)
		skipButton.setBackgroundImage(forwardImageWhite, forState: .Focused)
		skipButton.tintColor = focusedColor
		skipButton.adjustsImageWhenHighlighted = false
		skipButton.addTarget(self, action: #selector(trackPlayerViewSkipTrack(_:)), forControlEvents: .PrimaryActionTriggered)
		
		songLabel.font = UIFont(name: "Avenir-Heavy", size: 30.0)
		songLabel.numberOfLines = 1
		songLabel.textAlignment = .Center
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateTrackLabel), name: "AddTrackToQueue", object: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureSubviews() {
		let maxWidth = bounds.width - 2 * Constants.padding
		let songLabelSize = songLabel.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.max))
		songLabel.frame.size = songLabelSize
		
		skipButton.currentBackgroundImage?.imageWithRenderingMode(.AlwaysTemplate)
		
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
		avPlayerContainer.frame = CGRect(x: Constants.padding, y: Constants.padding + songLabel.bounds.maxY, width: ceil(bounds.width - 2 * Constants.padding), height: Constants.containerHeight)
		
		let centerX = floor(bounds.width / 2)
		playStopButton.frame = CGRectMake(centerX - floor(Constants.controlButtonSize.width / 2), floor((avPlayerContainer.bounds.height - Constants.controlButtonSize.height) / 2) , Constants.controlButtonSize.width, Constants.controlButtonSize.height)
		skipButton.frame = CGRectMake(playStopButton.frame.maxX + Constants.controlButtonsPadding, floor((avPlayerContainer.bounds.height - Constants.controlButtonSize.height) / 2) , Constants.controlButtonSize.width, Constants.controlButtonSize.height)
	}
	
	override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
		super.didUpdateFocusInContext(context, withAnimationCoordinator: coordinator)
		
//		let tintedPlayStop = playStopButton.currentBackgroundImage?.imageWithRenderingMode(.AlwaysTemplate)
//		playStopButton.setBackgroundImage(tintedPlayStop, forState: .Focused)
//
//		let tintedSkip = skipButton.currentBackgroundImage?.imageWithRenderingMode(.AlwaysTemplate)
//		skipButton.setBackgroundImage(tintedSkip, forState: .Focused)
		
		if playStopButton == context.previouslyFocusedView {
			playStopButton.transform = CGAffineTransformMakeScale(1, 1)
		} else if playStopButton ==  context.nextFocusedView {
			playStopButton.transform = CGAffineTransformMakeScale(1.3, 1.3)
		}
		
		if skipButton ==  context.previouslyFocusedView {
			skipButton.transform = CGAffineTransformMakeScale(1, 1)
		} else if skipButton ==  context.nextFocusedView {
			skipButton.transform = CGAffineTransformMakeScale(1.3, 1.3)
		}
	}
	
	@objc private func updateTrackLabel() {
		if let currentTrack = TrackManager.currentTrack() {
			songLabel.text = "\(currentTrack.artist) - \(currentTrack.title)"
		} else {
			songLabel.text = "Waiting For Track. Queue is empty."
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

	private func trackPlayerViewPlayTrack(sender: AnyObject) {
		TrackManager.playCurrentTrack()
		guard TrackManager.isPlayingTrack else { return }
		playStopButton.setBackgroundImage(pauseImage, forState: .Normal)
		playStopButton.setBackgroundImage(pauseImageWhite, forState: .Focused)
	}
	
	private func trackPlayerViewPauseTrack(sender: AnyObject) {
		TrackManager.pauseCurrentTrack()
		guard !TrackManager.isPlayingTrack else { return }
		playStopButton.setBackgroundImage(playImage, forState: .Normal)
		playStopButton.setBackgroundImage(playImageWhite, forState: .Focused)

	}
	
	@objc private func trackPlayerViewSkipTrack(sender: AnyObject) {
		TrackManager.skipCurrentTrack()
		updateTrackLabel()
		updateControlButtons()
		setNeedsFocusUpdate()
		updateFocusIfNeeded()
	}
	
	@objc private func updateControlButtons() {
		if TrackManager.isPlayingTrack {
			playStopButton.setBackgroundImage(pauseImage, forState: .Normal)
		} else {
			playStopButton.setBackgroundImage(playImage, forState: .Normal)
			playStopButton.setBackgroundImage(pauseImageWhite, forState: .Focused)
		}
	}

}
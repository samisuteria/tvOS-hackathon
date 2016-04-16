//
//  TrackPlayerView.swift
//  App
//
//  Created by Carlos Alban on 4/16/16.
//  Copyright © 2016 CGRekt. All rights reserved.
//

import UIKit
import AVKit

class TrackPlayerView: UIView {
	
	struct Constants {
		static let labelPadding: CGFloat = 15
		static let playerHeight: CGFloat = 50
	}
	
	private var songLabel: UILabel
	private var avPlayerView: AVPlayerView

	
	init(frame: CGRect, songName: String, track: Track) {
		avPlayerView = AVPlayerView(frame: CGRect.zero)
		songLabel = UILabel(frame: CGRect.zero)
		super.init(frame: frame)
		
		backgroundColor = UIColor.purpleColor()
		
		songLabel.font = UIFont.systemFontOfSize(30.0)
		songLabel.numberOfLines = 1
		songLabel.textAlignment = .Center
		songLabel.text = songName
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureSubviews() {
		let maxWidth = bounds.width - 2 * Constants.labelPadding
		let songLabelSize = songLabel.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.max))
		songLabel.frame.size = songLabelSize
		
		
		
		addSubview(songLabel)
		addSubview(avPlayerView)
	}
	
	override func layoutSubviews() {
		configureSubviews()
		avPlayerView.frame = CGRect(x: 0, y: 0, width: ceil(bounds.width - 2 * Constants.labelPadding), height: 50)
		songLabel.frame = CGRect(Constants.labelPadding, avPlayerView.frame.maxY, ceil(bounds.width - 2 * Constants.labelPadding), ceil(songLabel.bounds.height))
		
	}
}

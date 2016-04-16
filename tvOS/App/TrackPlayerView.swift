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
	}

	private var songLabel: UILabel
	private var avPlayer: AVPlayer

	
	init(frame: CGRect, songName: String, avPlayer: AVPlayer) {
		self.avPlayer = avPlayer
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
	}
	
	override func layoutSubviews() {
		configureSubviews()
		songLabel.frame = CGRectMake(Constants.labelPadding, floor((bounds.height - songLabel.bounds.height) / 2), ceil(bounds.width - 2 * Constants.labelPadding), ceil(songLabel.bounds.height))
	}
}

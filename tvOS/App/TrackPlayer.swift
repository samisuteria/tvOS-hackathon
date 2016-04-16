//
//  TrackPlayer.swift
//  App
//
//  Created by Carlos Alban on 4/16/16.
//  Copyright © 2016 CGRekt. All rights reserved.
//

import UIKit
import AVKit

class TrackPlayer: UIView {

	private var audioPlayer: AVPlayer
	
	init(frame: CGRect, url: NSURL!) {
		audioPlayer = AVPlayer(URL: url)
		super.init(frame: frame)
		backgroundColor = UIColor.purpleColor()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

//
//  TrackPlayer.swift
//  App
//
//  Created by Carlos Alban on 4/16/16.
//  Copyright © 2016 CGRekt. All rights reserved.
//

import AVKit

class TrackPlayer: AVPlayer {
	
	override init() {
		super.init()
	}
	
	override init(playerItem item: AVPlayerItem) {
		super.init(playerItem: item)
	}
	
	override init(URL: NSURL) {
		super.init(URL: URL)
	}
}

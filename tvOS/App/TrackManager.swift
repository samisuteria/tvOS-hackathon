//
//  TrackManager.swift
//  App
//
//  Created by Carlos Alban on 4/16/16.
//  Copyright © 2016 CGRekt. All rights reserved.
//

import Foundation

class TrackManager: NSObject {
	
	private(set) var currentlyPlayingTrack: Bool
	private(set) var trackAvailableToPlay: Bool
	
	override init() {
		currentlyPlayingTrack = false
		trackAvailableToPlay = false
		super.init()
	}
	
	class func currentTrack() -> Track {
		let track = Track(title: "Temp", artist: "Temp", soundcloudID: "Temp", URL: NSURL(string: "URL")!)
		return track
	}
	
	class func currentQueue() {
		
	}
	
	class func addTrackToQueue() {
		
	}
	
	class func removeTrackFromQueue() {
		
	}
	
	class func playCurrentTrack() {
		
	}
	
	class func stopCurrentTrack() {
		
	}
	
	class func skipCurrentTrack() {
		
	}
	
	class func trackForUser(userID: String) -> Track {
		let track = Track(title: "Temp", artist: "Temp", soundcloudID: "Temp", URL: NSURL(string: "URL")!)
		return track
	}

}

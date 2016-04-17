//
//  TrackManager.swift
//  App
//
//  Created by Carlos Alban on 4/16/16.
//  Copyright © 2016 CGRekt. All rights reserved.
//

import Foundation
import AVKit

class TrackManager: NSObject {
	
	// Note: Using Class Methods instead of Singleton
//	static let sharedInstance = TrackManager() // Guaranteed Singelton
	
	private(set) static var isPlayingTrack = false
	private static var track: Track?
	
	private static var avPlayer = AVPlayer(URL: NSURL())
	private static var queue = [Track?]()
	
	override private init() {
		super.init()
	}
	
	class func currentTrack() -> Track? {
		guard track != nil else {
			print("no track available")
			return nil
		}
		return track
	}
	
	class func currentQueue() -> [Track?] {
		return queue
	}
	
	class func addTrackToQueue(newTrack: Track) {
		var tempArray = queue
		tempArray.append(newTrack)
		queue = tempArray

		guard track == nil, let nextTrack = queue.first else {
			print("queue is empty")
			return
		}
		track = nextTrack
		queue.removeFirst()
		NSNotificationCenter.defaultCenter().postNotificationName("AddTrackToQueue", object: nil)
	}
	
	class func addTracksToQueue(newTracks: [Track]) {
		for track in newTracks {
			addTrackToQueue(track)
		}
	}
	
	class func removeTrackFromQueue(trackToRemove: Track) {
		var tempArray = queue
		for (index, track) in tempArray.enumerate() {
			if (track?.soundcloudID == trackToRemove.soundcloudID) && (track?.userID == trackToRemove.userID) {
				tempArray.removeAtIndex(index)
			}
		}
		queue = tempArray
		NSNotificationCenter.defaultCenter().postNotificationName("RemoveTrackFromQueue", object: nil)
	}
	
	class func playCurrentTrack() {
		print("play pressed")
		guard let currentTrack = track else { return }
		let asset = AVAsset(URL: currentTrack.URL)
		let playerItem = AVPlayerItem(asset: asset)
		avPlayer = AVPlayer(playerItem: playerItem)
		isPlayingTrack = true
		avPlayer.play()
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(trackDidFinishPlaying), name: AVPlayerItemDidPlayToEndTimeNotification, object: avPlayer)
	}
	
	class func pauseCurrentTrack() {
		print("pause pressed")
		guard (track != nil) else { return }
		isPlayingTrack = false
		avPlayer.pause()
		NSNotificationCenter.defaultCenter().removeObserver(self, name: AVPlayerItemDidPlayToEndTimeNotification, object: avPlayer)
	}
	
	class func skipCurrentTrack() {
		print("skip pressed")
		pauseCurrentTrack()
		guard let nextTrack = queue.first else {
			print("queue is empty")
			return
		}
		track = nextTrack
		queue.removeFirst()
		NSNotificationCenter.defaultCenter().postNotificationName("RemoveTrackFromQueue", object: nil)
		playCurrentTrack()
	}
	
	@objc private class func trackDidFinishPlaying() {
		print("autoplaying next track")
		skipCurrentTrack()
	}
	
	class func trackForUser(userID: String) -> Track {
		let track = Track(title: "Temp", artist: "Temp", soundcloudID: "Temp", URL: NSURL(string: "URL")!, userID: "123")
		return track
	}

}

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
			NSNotificationCenter.defaultCenter().postNotificationName("UpdateQueue", object: nil)
			return
		}
		track = nextTrack
		queue.removeFirst()
		NSNotificationCenter.defaultCenter().postNotificationName("AddTrackToQueue", object: nil)
		print("track \(track) added!")
	}
	
	class func addTracksToQueue(newTracks: [Track]) {
		for track in newTracks {
			addTrackToQueue(track)
		}
	}
	
	class func removeTrackFromQueue(trackToRemove: Track) {
        var tempArray = queue
		for (index, track) in tempArray.enumerate() {
			if (track?.soundcloudID == trackToRemove.soundcloudID) {
				tempArray.removeAtIndex(index)
                break
			}
		}
		queue = tempArray
		NSNotificationCenter.defaultCenter().postNotificationName("RemoveTrackFromQueue", object: nil)
	}
	
	class func loadAndPlayTrack(trackToLoad: Track) {
		track = trackToLoad
		removeTrackFromQueue(trackToLoad)
		NSNotificationCenter.defaultCenter().postNotificationName("UpdateQueue", object: nil)
		playCurrentTrack()
	}
	
	class func playCurrentTrack() {
		print("play pressed")
		guard let currentTrack = track else { return }
		let asset = AVAsset(URL: currentTrack.URL)
		let playerItem = AVPlayerItem(asset: asset)
//		print(asset.duration)
		avPlayer = AVPlayer(playerItem: playerItem)
		isPlayingTrack = true
		avPlayer.play()
		//AVPlayerItemFailedToPlayToEndTimeNotification
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(trackDidFinishPlaying), name: AVPlayerItemDidPlayToEndTimeNotification, object: avPlayer.currentItem)
	}
	
	class func pauseCurrentTrack() {
		print("pause pressed")
		isPlayingTrack = false
		guard (track != nil) else {
			NSNotificationCenter.defaultCenter().postNotificationName("UpdateQueue", object: nil)
			return
		}
		avPlayer.pause()
		NSNotificationCenter.defaultCenter().removeObserver(self, name: AVPlayerItemDidPlayToEndTimeNotification, object: avPlayer.currentItem)
	}
	
	class func skipCurrentTrack() {
		print("skip pressed")
		pauseCurrentTrack()
		guard let nextTrack = queue.first else {
			print("queue is empty")
			NSNotificationCenter.defaultCenter().postNotificationName("UpdateQueue", object: nil)
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

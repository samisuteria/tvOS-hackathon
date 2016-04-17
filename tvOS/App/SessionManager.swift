//
//  SessionManager.swift
//  App
//
//  Created by Carlos Alban on 4/16/16.
//  Copyright © 2016 CGRekt. All rights reserved.
//

import UIKit


class SessionManager: NSObject {
	
	static let sharedInstance = SessionManager()
	private(set) var synchingSession: Bool
	private(set) var sessionUsers: NSSet
	
	override private init() {
		synchingSession = false
		sessionUsers = []
		super.init()
	}
	
	class func syncSession() {
		
	}
	
	class func startNewSession(){
		
	}
	
	private func endCurrentSession() {
		
	}
	
	class func usersInCurrentSession() -> [User] {
        return [User(userID: "asdas", name: "asdasd", avatar: UIImage(named: "asdasd")!)]
	}
	
	class func addUserToCurrentSession(userID: String) {
		
	}
	
	class func removeUserFromCurrentSession(userID: String) {
		
	}

}

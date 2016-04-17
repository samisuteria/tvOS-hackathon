import Foundation
import SocketIOClientSwift

protocol ServerManagerDelegate {
    func serverManagerAssignedRoom(room: String)
//    func serverManagerGotSongIDToQueue(songID: String)
}

class ServerManager {
    
    static let sharedManager = ServerManager()
    let socket = SocketIOClient(socketURL: NSURL(string: "https://cgrektserver.herokuapp.com")!, options: [.Log(false), .ForcePolling(true)])
    
    var delegate: ServerManagerDelegate?
    var currentRoom = ""
    
    init() {
        addHandlers()
        socket.connect()
    }
    
    
    private func addHandlers() {
        socket.on("connect") { (data: [AnyObject], ack: SocketAckEmitter) in
            print("socket connected")
            self.socket.emit("createRoom", withItems: ["hello"])
        }
        
        socket.on("createdRoom") { (data: [AnyObject], ack: SocketAckEmitter) in
            if let data = data as? [String] where data.count == 1 {
                print(data[0])
                self.delegate?.serverManagerAssignedRoom(data[0])
                self.currentRoom = data[0]
            }
        }
        
        socket.on("addToQueue") { (data: [AnyObject], ack: SocketAckEmitter) in
            if let data = data as? [String] where data.count == 1 {
                print(data[0])
				//self.delegate?.serverManagerGotSongIDToQueue(data[0])
                SoundCloudClient.sharedClient.addID(data[0])
            }
        }
        
        socket.onAny { (event: SocketAnyEvent) in
            //print("event: \(event)")
        }
    }
}
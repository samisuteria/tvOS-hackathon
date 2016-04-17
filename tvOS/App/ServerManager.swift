import Foundation
import SocketIOClientSwift

protocol ServerManagerDelegate {
    func serverManagerAssignedRoom(room: String)
}

class ServerManager {
    
    static let sharedManager = ServerManager()
    let socket = SocketIOClient(socketURL: NSURL(string: "http://192.168.1.142:3000")!, options: [.Log(false), .ForcePolling(true)])
    
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
        
        socket.onAny { (event: SocketAnyEvent) in
            print("event: \(event)")
        }
    }
}
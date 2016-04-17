import Foundation
import SocketIOClientSwift

class ServerManager {
    
    static let sharedManager = ServerManager()
    let socket = SocketIOClient(socketURL: NSURL(string: "http://localhost:3000")!, options: [.Log(true), .ForcePolling(true)])
    
    init() {
        addHandlers()
        socket.connect()
    }
    
    
    private func addHandlers() {
        socket.on("connection") { (data: [AnyObject], ack: SocketAckEmitter) in
            print("socket connected")
            
            self.socket.emit("createRoom", "hello")
        }
        
        
    }
}
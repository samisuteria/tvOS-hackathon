import Foundation
import SocketIOClientSwift

protocol ServerManagerRoomListDelegate {
    func serverManagerUpdatedRoomList()
}

class ServerManager {
    
    static let sharedManager = ServerManager()
    let socket = SocketIOClient(socketURL: NSURL(string: "http://localhost:3000")!, options: [.Log(true), .ForcePolling(true)])
    
    var roomnames = [String]()
    
    var roomlistDelegate: ServerManagerRoomListDelegate?
    
    init () {
        addHandlers()
        socket.connect()
    }
    
    private func addHandlers() {
        
        socket.on("connection") { (data: [AnyObject], ack: SocketAckEmitter) in
            print("socket connected")
        }
        
        socket.on("roomlist") { [unowned self] (data: [AnyObject], ack: SocketAckEmitter) in
            print("roomlist")
            if let data = data as? [[String]] {
                data[0].forEach({ (room: String) in
                    self.roomnames.append(room)
                })
            }
            self.roomlistDelegate?.serverManagerUpdatedRoomList()
        }
        
        socket.onAny { (event: SocketAnyEvent) in
            print("got something")
        }
    }
    
}
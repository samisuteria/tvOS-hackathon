import Foundation
import SocketIOClientSwift

protocol ServerManagerRoomListDelegate {
    func serverManagerUpdatedRoomList()
}

class ServerManager {
    
    static let sharedManager = ServerManager()
    let socket = SocketIOClient(socketURL: NSURL(string: "https://cgrektserver.herokuapp.com")!, options: [.Log(true), .ForcePolling(true)])
    
    var roomnames = [String]()
    var currentRoom = ""
    
    var roomlistDelegate: ServerManagerRoomListDelegate?
    
    init () {
        addHandlers()
        socket.connect()
    }
    
    func joinRoom(room: String) {
        currentRoom = room
        socket.emit("joinRoom", withItems: [room])
    }
    
    func addSong(track: SoundCloudTrackModel) {
        
        socket.emit("addSong", withItems: [track.id, currentRoom])
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
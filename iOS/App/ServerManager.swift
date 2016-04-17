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
    
    func refreshRoomList() {
        socket.emit("refreshList", withItems: ["hello"])
    }
    
    private func addHandlers() {
        
        socket.on("connect") { (data: [AnyObject], ack: SocketAckEmitter) in
            print("socket connected")
            self.socket.emit("refreshList", withItems: ["hello"])
        }
        
        socket.on("roomlist") { [unowned self] (data: [AnyObject], ack: SocketAckEmitter) in
            print("roomlist")
            if let data = data as? [[String]] {
                self.roomnames.removeAll()
                data[0].forEach({ (room: String) in
                    self.roomnames.append(room)
                })
            }
            self.roomlistDelegate?.serverManagerUpdatedRoomList()
        }
        
        socket.onAny { (event: SocketAnyEvent) in
            print("event: \(event)")
        }
    }
    
}
//
//  Room.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 02/01/25.
//

import Foundation

struct Room {
    let title: String
//    let userIds: [Int]
    var participantsJoined: Int
    let totalParticipants: Int
    let topic: String
    let level: String
    var isLive: Bool
    let hostName: String
}

class RoomDataModel {
    
    // Singleton instance
    static let shared = RoomDataModel()
    
    // Private initializer to ensure no external instantiation
    private init() {}
    
    // Array of rooms to store the room data
    private var rooms: [Room] = [
        Room(title: "Public Speaking Essentials",
             participantsJoined: 12,
             totalParticipants: 50,
             topic: "Impromptu Speaking",
             level: "Beginner",
             isLive: true,
             hostName: "Alice Johnson"),
        
        Room(title: "Advanced Debate Strategies",
             participantsJoined: 25,
             totalParticipants: 40,
             topic: "Competitive Debating",
             level: "Advanced",
             isLive: false,
             hostName: "Michael Smith"),
        
        Room(title: "Storytelling Techniques",
             participantsJoined: 18,
             totalParticipants: 35,
             topic: "Narrative Building",
             level: "Intermediate",
             isLive: true,
             hostName: "Sarah Lee"),
        
        Room(title: "Mastering Body Language",
             participantsJoined: 10,
             totalParticipants: 30,
             topic: "Non-verbal Communication",
             level: "Beginner",
             isLive: false,
             hostName: "John Brown"),
        
        Room(title: "Persuasive Speaking Workshop",
             participantsJoined: 30,
             totalParticipants: 45,
             topic: "Influence and Persuasion",
             level: "Advanced",
             isLive: true,
             hostName: "Emily Davis"),
        
        Room(title: "Overcoming Stage Fear",
             participantsJoined: 15,
             totalParticipants: 25,
             topic: "Confidence Building",
             level: "Beginner",
             isLive: true,
             hostName: "David Clark"),
        
        Room(title: "Voice Modulation Techniques",
             participantsJoined: 20,
             totalParticipants: 40,
             topic: "Vocal Delivery",
             level: "Intermediate",
             isLive: false,
             hostName: "Olivia Wilson")
    ]
    
    // Method to fetch all rooms
    func getAllRooms() -> [Room] {
        return rooms
    }
    
    // Method to fetch live rooms only
    func getLiveRooms() -> [Room] {
        return rooms.filter { $0.isLive }
    }
    
    // Method to get rooms by a specific level
    func getRooms(byLevel level: String) -> [Room] {
        return rooms.filter { $0.level == level }
    }
    
    // Method to add a new room
    func addRoom(_ room: Room) {
        rooms.append(room)
    }
    
    // Method to update the room's participant count
    func updateRoomParticipants(roomTitle: String, newParticipants: Int) {
        if let index = rooms.firstIndex(where: { $0.title == roomTitle }) {
            rooms[index].participantsJoined = newParticipants
        }
    }
    
    // Method to toggle live status of a room
    func toggleRoomLiveStatus(roomTitle: String) {
        if let index = rooms.firstIndex(where: { $0.title == roomTitle }) {
            rooms[index].isLive.toggle()
        }
    }
    
    // Method to get a room by its title
    func getRoomByTitle(_ title: String) -> Room? {
        return rooms.first(where: { $0.title == title })
    }
}

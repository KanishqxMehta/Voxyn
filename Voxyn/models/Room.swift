//
//  Room.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 02/01/25.
//

import Foundation

struct Room {
    let title: String
    let participantsJoined: Int
    let totalParticipants: Int
    let topic: String
    let level: String
    let isLive: Bool
    let hostName: String // Renamed from 'host' for clarity
}

// Updated array with consistent naming and proper initialization
var rooms: [Room] = [
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

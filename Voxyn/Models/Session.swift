//
//  Session.swift
//  Voxyn
//
//  Created by student-2 on 26/03/25.
//

import Foundation

struct Session {
    let userId : Int
    var numOfSession : Int
}

class SessionDataModel{
   static let shared = SessionDataModel()
    
    private var sessions : [Session] = [
        Session(userId: 0, numOfSession: 0)
    ]
    
    func updateSessionCount(for userId: Int) {
           if let index = sessions.firstIndex(where: { $0.userId == userId }) {
               sessions[index].numOfSession += 1
           } else {
               sessions.append(Session(userId: userId, numOfSession: 1))
           }
       }
       
       // Function to fetch session count for a given userId
       func fetchSessionCount(for userId: Int) -> Int {
           return sessions.first(where: { $0.userId == userId })?.numOfSession ?? 0
       }
    
    
}

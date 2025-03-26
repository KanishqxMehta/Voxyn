//
//  Streak.swift
//  Voxyn
//
//  Created by student-2 on 26/03/25.
//

import Foundation

struct Streak {
    
    let userId : Int
    var streakCount : Int
    var lastRecordingDate : Int
    
}

class StreakDataModel {
    static let shared = StreakDataModel()
    
    private var streaks : [Streak] =
    [
        Streak(userId: 0, streakCount: 3, lastRecordingDate: 1742860800)
        
    ]
    
    
    func fetchStreakCount(userId: Int) -> Int {
        
        if let userStreak = streaks.first(where: {$0.userId == userId}){
            return userStreak.streakCount
        } else {
            return 0
        }
        
    }
    
    
//    func updateStreak(userId: Int) {
//            let currentTimestamp = Int(Date().timeIntervalSince1970) // Current time in seconds
//            let secondsInADay = 86400 // 24 hours in seconds
//            
//            if let index = streaks.firstIndex(where: { $0.userId == userId }) {
//                let lastTimestamp = streaks[index].lastRecordingDate
//                let timeDifference = currentTimestamp - lastTimestamp
//                
//                if timeDifference >= secondsInADay && timeDifference < secondsInADay * 2 {
//                    // If last recording was exactly 1 day ago, increase the streak
//                    streaks[index].streakCount += 1
//                } else if timeDifference >= secondsInADay * 2 {
//                    // If missed a day, reset streak to 0
//                    streaks[index].streakCount = 0
//                }
//
//                // Update last recording date to current timestamp
//                streaks[index].lastRecordingDate = currentTimestamp
//            } else {
//                // If user does not exist in streaks, create a new entry
//                streaks.append(Streak(userId: userId, streakCount: 1, lastRecordingDate: currentTimestamp))
//            }
//        }
    
    func updateStreakIfValid( userId: Int) {
           let currentTimestamp = Int(Date().timeIntervalSince1970)
           let oneDayInSeconds = 86400 // 24 hours

           if let index = streaks.firstIndex(where: { $0.userId == userId }) {
               let lastRecording = streaks[index].lastRecordingDate

               if currentTimestamp - lastRecording >= oneDayInSeconds {
                   // Increase streak if more than 24 hours have passed
                   streaks[index].streakCount += 1
                   streaks[index].lastRecordingDate = currentTimestamp
                   print("Streak increased to \(streaks[index].streakCount) for user \(userId)")
               } else {
                   print("Streak unchanged. Last recording was within 24 hours.")
               }
           }
       }
    
    
    
    func checkAndResetStreak( userId: Int) {
        let currentTimestamp = Int(Date().timeIntervalSince1970)
        let oneDayInSeconds = 86400 // 24 hours

        if let index = streaks.firstIndex(where: { $0.userId == userId }) {
            let lastRecording = streaks[index].lastRecordingDate

            if currentTimestamp - lastRecording > oneDayInSeconds {
                // Reset streak if more than 24 hours have passed
                streaks[index].streakCount = 0
                print("Streak reset to 0 for user \(userId)")
            } else {
                print("Streak is still active for user \(userId)")
            }
        }
    }
}

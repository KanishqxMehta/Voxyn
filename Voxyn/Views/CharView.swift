import SwiftUI
import Charts

struct ChartView: View {
    // Recordings passed from parent view
    let recordings: [Recording]
    
    // Initialize with provided recordings or fetch them if not provided
    init(recordings: [Recording]? = nil) {
        if let providedRecordings = recordings {
            self.recordings = providedRecordings
        } else if let currentUserId = UserDataModel.shared.getUser()?.userId {
            self.recordings = RecordingDataModel.shared.findRecordings(by: currentUserId)
        } else {
            self.recordings = []
        }
        
        // Debug print to check recordings
        print("Total Recordings: \(self.recordings.count)")
        print("Recording IDs: \(self.recordings.map { $0.recordingId })")
    }
    
    var body: some View {
        VStack {
            if recordings.isEmpty {
                Text("No data found")
                    .foregroundColor(.red)
            } else {
                let chartData = prepareChartData()
                
                // Debug print chart data
                Text("Chart Data Points: \(chartData.count)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                if chartData.isEmpty {
                    Text("No feedback data available")
                        .foregroundColor(.red)
                } else {
                    Chart(chartData) { dataPoint in
                        LineMark(
                            x: .value("Day", dataPoint.day),
                            y: .value("Score", dataPoint.score)
                        )
                        .foregroundStyle(by: .value("Category", dataPoint.category.displayName))
                    }
                    .chartForegroundStyleScale([
                        "Clarity": Color.blue,
                        "Tone": Color.purple,
                        "Pace": Color.orange,
                        "Fluency": Color.pink
                    ])
                    .chartYAxis {
                        AxisMarks(position: .leading, values: Array(stride(from: 0, to: 101, by: 25)))
                    }
                    .chartXAxis {
                        AxisMarks(position: .bottom) { value in
                            AxisValueLabel {
                                if let day = value.as(String.self) {
                                    Text(day.prefix(3))
                                        .font(.caption)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func prepareChartData() -> [ChartDataPoint] {
        var dataPoints: [ChartDataPoint] = []
        
        let calendar = Calendar.current
        let today = Date()
        
        // Get the start of the current week (Monday)
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
        
        // Get all days of the current week (Monday to Sunday)
        var weekDays: [String] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        for i in 0..<7 {
            if let day = calendar.date(byAdding: .day, value: i, to: startOfWeek) {
                weekDays.append(dateFormatter.string(from: day))
            }
        }
        
        // Initialize scores for each day with zero values
        var weeklyScores: [String: [FeedbackCategory: Int]] = [:]
        for dayName in weekDays {
            weeklyScores[dayName] = [
                .clarity: 0,
                .tone: 0,
                .pace: 0,
                .fluency: 0
            ]
        }
        
        // Find all feedbacks for the recordings
        let allFeedbacks = FeedbackDataModel.shared.findFeedbacks(by: recordings.map { $0.recordingId })
        
        for recording in recordings {
            let dayOfWeek = dateFormatter.string(from: recording.timestamp)
            
            // Find feedback for the current recording
            if let feedback = allFeedbacks.first(where: { $0.recordingId == recording.recordingId }) {
                for (category, score) in feedback.scores {
                    weeklyScores[dayOfWeek]?[category] = score
                }
            }
        }
        
        // Convert weeklyScores into ChartDataPoint array
        for (day, scores) in weeklyScores {
            for (category, score) in scores {
                dataPoints.append(ChartDataPoint(day: day, category: category, score: score))
            }
        }
        
        // Sort data points in correct week order
        dataPoints.sort { data1, data2 in
            if let index1 = weekDays.firstIndex(of: data1.day), let index2 = weekDays.firstIndex(of: data2.day) {
                return index1 < index2
            }
            return false
        }
        
        return dataPoints
    }
}

// Helper struct for chart data points
struct ChartDataPoint: Identifiable {
    let id = UUID()
    let day: String
    let category: FeedbackCategory
    let score: Int
}

// Preview
#Preview {
    ChartView()
}

import SwiftUI
import Charts

struct ChartView: View {
    // Fetch recordings from the data model
    let recordings = RecordingDataModel.shared.findRecordings(by: 1) // Assuming userId = 1
    
    var body: some View {
        if recordings.isEmpty {
            VStack {
                Text("No data")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            let chartData = prepareChartData()
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
                            Text(day.prefix(3)) // Shortened day names (e.g., Mon, Tue)
                                .font(.caption)
                        }
                    }
                }
            }
        }
    }
    
    // Convert recording data into chart-friendly data points
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
        
        var weeklyScores: [String: [FeedbackCategory: Int]] = [:]
        
        for dayName in weekDays {
            weeklyScores[dayName] = [
                .clarity: 0,
                .tone: 0,
                .pace: 0,
                .fluency: 0
            ]
        }
        
        for recording in recordings {
            let dayOfWeek = dateFormatter.string(from: recording.timestamp)
            if weeklyScores.keys.contains(dayOfWeek) {
                for (category, score) in recording.feedback.scores {
                    weeklyScores[dayOfWeek]?[category] = score
                }
            }
        }
        
        for (day, scores) in weeklyScores {
            for (category, score) in scores {
                dataPoints.append(ChartDataPoint(day: day, category: category, score: score))
            }
        }
        
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

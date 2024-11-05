import Foundation

extension Date {
    func formattedDateTime() -> String {
        self.formatted(
            .dateTime
                .year().month().day()
                .hour().minute()
                .locale(Locale(identifier: "ja_JP"))
                .year(.defaultDigits)
                .month(.defaultDigits)
                .day(.defaultDigits)
                .hour(.defaultDigits(amPM: .omitted))
                .minute(.defaultDigits)
        )
    }
} 

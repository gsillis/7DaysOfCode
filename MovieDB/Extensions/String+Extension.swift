import Foundation

extension String {
   func formatDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ss") -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"

        if let date = dateFormatterGet.date(from: self) {
            let dateFormated = (dateFormatterPrint.string(from: date))
            return dateFormated
        } else {
            print("There was an error decoding the string")
           return ""
        }
    }
}

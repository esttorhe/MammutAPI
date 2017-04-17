//
// Created by Esteban Torres on 17.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

internal extension DateFormatter {
    static func mastodonDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        return dateFormatter
    }
}

extension Date {
    init?(from dateString: String) {
        let formatter = DateFormatter.mastodonDateFormatter()

        guard let date = formatter.date(from: dateString) else {
            return nil
        }

        self.init(timeInterval: 0, since: date)
    }
}
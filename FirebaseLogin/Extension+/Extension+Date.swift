//
//  Extension+Date.swift
//  FirebaseLogin
//
//  Created by Sezgin on 9.05.2022.
//

import Foundation

extension String {
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let actualDate = dateFormatter.date(from: self) ?? .now
        dateFormatter.dateFormat = "dd MMM HH:mm"
        let dateString = dateFormatter.string(from: actualDate)
        return dateString
    }
}

//
//  UtilityExtensions.swift
//  MovieBrowser
//
//  Created by Avi on 5/17/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

extension Data{
    var prettyPrintedJSON: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []), let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        else { return nil }
    return prettyPrintedString
    }
}

extension Date{
    public func string(withFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    public func date(strDate: String, withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        let date = dateFormatter.date(from: strDate)
        return date
    }
    
}



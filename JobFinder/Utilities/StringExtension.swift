//
//  StringExtension.swift
//  JobFinder
//
//  Created by Nfonics on 28/06/19.
//  Copyright © 2019 Nfonics. All rights reserved.
//

import Foundation
extension String{
  
    var dateMonthYearStringGit: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E MMM d HH:mm:ss Z yyyy" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
        //according to date format your date string
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        return date.dateString
    }
    
    var dateMonthYearStringGov: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
        //according to date format your date string
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        return date.dateString
    }
}

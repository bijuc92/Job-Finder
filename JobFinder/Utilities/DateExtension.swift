//
//  Date.swift
//  JobFinder
//
//  Created by Nfonics on 28/06/19.
//  Copyright © 2019 Nfonics. All rights reserved.
//

import Foundation
extension Date{
    func dateFrom(string: String){
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "E MMM d HH:mm:ss Z yyyy"//Git date formatter
        
    }
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyy"
        return dateFormatter.string(from: self)
    }
}

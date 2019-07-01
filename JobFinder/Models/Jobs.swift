//
//  Jobs.swift
//  JobFinder
//
//  Created by Nfonics on 27/06/19.
//  Copyright © 2019 Nfonics. All rights reserved.
//

import UIKit
import SwiftyJSON

class Jobs: NSObject{
    var id: String?
    var type: String?
    var url: String?
    var created_at: String?
    var company: String?
    var company_url: String?
    var location: String?
    var title: String?
    var jobDescription: String?
    var how_to_apply: String?
    var company_logo: String?
    
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case type = "type"
//        case url = "url"
//        case created_at = "created_at"
//        case company = "company"
//        case company_url = "company_url"
//        case location = "location"
//        case title = "title"
//        case description = "description"
//        case how_to_apply = "how_to_apply"
//        case company_logo = "company_logo"
//    }
    
    init(first: JSON){
        self.id = first["id"].string ?? ""
        self.type = first["id"].string  ?? ""
        self.url = first["url"].string ?? ""
        self.company = first["company"].string ?? ""
        self.created_at = first["created_at"].string?.dateMonthYearStringGit ?? ""
        self.company_url = first["company_url"].string ?? ""
        self.location = first["location"].string ?? ""
        self.title = first["title"].string ?? ""
        self.company_logo = first["company_logo"].string ?? ""
    }
    
    init(second: JSON){
        self.id = second["id"].string ?? ""
        self.title = second["position_title"].string ?? ""
        self.url = second["url"].string ?? ""
        self.company = second["organization_name"].string ?? ""
        let locations = second["locations"].array
        var location = ""
        for loc in locations!{
            location.append(loc.string ?? "")
        }
        self.location = location
        self.created_at = second["start_date"].string?.dateMonthYearStringGov ?? ""
        self.id = second["id"].string ?? ""
    }
    
}


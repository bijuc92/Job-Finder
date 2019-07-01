//
//  AppConfig.swift
//  JobFinder
//
//  Created by Nfonics on 27/06/19.
//  Copyright © 2019 Nfonics. All rights reserved.
//

import Foundation
private let _AppConfigSharedInstance = AppConfig()
class AppConfig {
    class var shared: AppConfig {
        return _AppConfigSharedInstance
    }
    
    func getBaseUrlof(provider: Provider) -> String{
        switch provider{
        case .all:
            return "https://jobs.github.com/positions.json?"
        case .git:
            return "https://jobs.github.com/positions.json?"
        case .gov:
            return "https://jobs.search.gov/jobs/search.json?"
        }
    }
    
    static let googleAPIKey = "AIzaSyDDOuuAWB9W6jN1rG7sVrq4Dk-UJDl1yDA"
    
}

/* Providers list */
enum Provider{
    case all
    case git
    case gov
}

/* Position */
enum Position{
    case all
    case fulltime
    case parttime
}

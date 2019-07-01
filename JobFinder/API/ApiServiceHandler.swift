//
//  ApiServiceHandler.swift
//  JobFinder
//
//  Created by Nfonics on 27/06/19.
//  Copyright © 2019 Nfonics. All rights reserved.
//

import UIKit
import SwiftyJSON

class ApiServiceHandler: NSObject {
    
    static let shared = ApiServiceHandler()
    var appConfig:AppConfig = AppConfig.shared
    
    func getJobsListForProviederAWith(url: String, provider: Provider, page: Int, completion: @escaping ([Jobs])->Void){
        var jobs: [Jobs] = [Jobs]()
        let pageString = String(page)
        print(pageString)
        let urlPath = url //"https://jobs.github.com/positions.json?page=" + "\(page)" //appConfig.webServiceUrl + appConfig.getJobList
        print(urlPath)
        let session = URLSession.shared
        session.dataTask(with: URL(string: urlPath)!) { (data, respose, error) in
            if error == nil{
                if data != nil{
                    if let json = try? JSON(data: data!){
                        for value in json.array!{
                            
                            switch provider{
                            case .git:
                                jobs.append(Jobs(first: value))
                            case .gov:
                                jobs.append(Jobs(second: value))
                            case .all:
                                jobs.append(Jobs(first: value))
                            }
                        }
                        completion(jobs)
                    }
                }
            }else{
                print("Error: \(error.debugDescription)")
                completion(jobs)
            }
            
            }.resume()
    }
    
}

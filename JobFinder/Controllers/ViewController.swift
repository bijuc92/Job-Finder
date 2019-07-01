//
//  ViewController.swift
//  JobFinder
//
//  Created by Nfonics on 27/06/19.
//  Copyright © 2019 Nfonics. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    static let cellId = "JobsTableViewCell"
    var jobs: [Jobs]?
    var pageCount: Int? //For pagination
    var isLoading: Bool? //Loading check
    var currentDate = Date()
    var provider: Provider?
    var isAllProvider: Bool? //For filtering is enabled
    var positionValue = ""
    var currentProvider: Provider?
    var currentPosition: Position?
    var location: JLocation?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
        self.configureView()
        jobs = [Jobs]()
        pageCount = 0
        isLoading = false
        isAllProvider = true
        currentPosition = Position.all
        currentProvider = Provider.all
        self.location = ("",0,0)
        self.setupGetJobList(provider: currentProvider!, position: currentPosition!, location: self.location!)
        
    }
    
    func configureView(){
        navigationItem.title = "Jobs"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    func registerCell(){
        self.tableView.register(UINib(nibName: ViewController.cellId, bundle: nil), forCellReuseIdentifier: ViewController.cellId)
    }

    @IBAction func didPressFilter(_ sender: Any) {
        let navVc = storyboard?.instantiateViewController(withIdentifier: "FilterNavigation") as? UINavigationController
        let vc = navVc?.topViewController as? FilterViewController
        vc?.delegate = self
        vc?.selectedProvider = currentProvider
        vc?.selectedPosition = currentPosition
        vc?.location = self.location
        self.present(navVc!, animated: true, completion: nil)
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellId, for: indexPath) as? JobsTableViewCell
        let job = jobs?[indexPath.row]
        cell?.jobTitleLabel.text = job?.title
        cell?.companyNameLabel.text = job?.company
        cell?.locationLabel.text = job?.location
        cell?.dateLabel.text =  job?.created_at
        cell?.iconImageView.kf.setImage(with:  URL(string:job?.company_logo ?? ""), placeholder: UIImage(named: "NoImage"))
        if (job!.id == jobs?.last?.id && indexPath.row == jobs!.count - 1){
            if !isLoading!{
                self.perform(#selector(getmoreRecodes), with: nil, afterDelay: 1.0)
            }
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let job = jobs?[indexPath.row]
        if let url = job?.url{
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
        }
       
    }
    
    @objc func getmoreRecodes(){
        isLoading = true
        pageCount = pageCount! + 1
        setupGetJobList(provider: currentProvider!, position: currentPosition!, location: self.location!)
    }
    
}

extension ViewController: FilterViewDelegate{
    
    func setupGetJobList(provider: Provider, position: Position, location: JLocation){
        var size = pageCount! * 50
        if size == 0{
            size = 50
        }
        switch provider{
        case .all:
            switch position{
            case .all:
                var url = AppConfig().getBaseUrlof(provider: provider) + "page=\(pageCount!)"
                if location.location != ""{
                    let loc = location.location.replacingOccurrences(of: " ", with: "+").lowercased()
                    url = AppConfig().getBaseUrlof(provider: provider) + "location=\(loc)"
                }
                
                isAllProvider = true
                self.getJobsListWith(provider: Provider.git, position: position, url: url)
            case .fulltime:
                var url = AppConfig().getBaseUrlof(provider: provider) + "full_time=true" + "&page=\(pageCount!)"
                if location.location != ""{
                    
                    let loc = location.location.replacingOccurrences(of: " ", with: "+").lowercased()
                    url = url + "&location=\(loc)"
                }
                isAllProvider = true
                positionValue = "query=fulltime"
                self.getJobsListWith(provider: Provider.git, position: position, url: url)
            case .parttime:
                var url = AppConfig().getBaseUrlof(provider: provider) + "full_time=false" + "&page=\(pageCount!)"
                if location.location != ""{
                    let loc = location.location.replacingOccurrences(of: " ", with: "+").lowercased()
                    url = url + "&location=\(loc)"
                }
                isAllProvider = true
                positionValue = "query=parttime"
                self.getJobsListWith(provider: Provider.git, position: position, url: url)
            }
            
        case .git:
            switch position{
            case .all:
                var url = AppConfig().getBaseUrlof(provider: provider) + "page=\(pageCount!)"
                if location.location != ""{
                    let loc = location.location.replacingOccurrences(of: " ", with: "+").lowercased()
                    url = url + "&location=\(loc)"
                }
                isAllProvider = true
                self.getJobsListWith(provider: provider, position: position, url: url)
            case .fulltime:
                var url = AppConfig().getBaseUrlof(provider: provider) + "full_time=true" + "&page=\(pageCount!)"
                if location.location != ""{
                    let loc = location.location.replacingOccurrences(of: " ", with: "+").lowercased()
                    url = url + "&location=\(loc)"
                }
                isAllProvider = false
                self.getJobsListWith(provider: provider, position: position, url: url)
            case .parttime:
                var url = AppConfig().getBaseUrlof(provider: provider) + "full_time=false" + "&page=\(pageCount!)"
                if location.location != ""{
                    let loc = location.location.replacingOccurrences(of: " ", with: "+").lowercased()
                    url = url + "&location=\(loc)"
                }
                isAllProvider = false
                self.getJobsListWith(provider: provider, position: position, url: url)
            }
        case .gov:
            switch position{
            case .all:
                var url = AppConfig().getBaseUrlof(provider: provider) + "size=\(size)"
                if location.location != ""{
                    let loc = "\(location.lat),\(location.lon)"
                    url = url + "&lat_lon=\(loc)"
                }
                isAllProvider = true
                self.getJobsListWith(provider: provider, position: position, url: url)
            case .fulltime:
                var url = AppConfig().getBaseUrlof(provider: provider) + "query=fulltime"  + "&size=\(size)"
                if location.location != ""{
                    let loc = "\(location.lat),\(location.lon)"
                    url = url + "&lat_lon=\(loc)"
                }
                isAllProvider = false
                self.getJobsListWith(provider: provider, position: position, url: url)
                
            case .parttime:
                var url = AppConfig().getBaseUrlof(provider: provider) + "query=parttime" + "&size=\(size)"
                if location.location != ""{
                    let loc = "\(location.lat),\(location.lon)"
                    url = url + "&lat_lon=\(loc)"
                }
                isAllProvider = false
                self.getJobsListWith(provider: provider, position: position, url: url)
            }
        }
    }
    
    
    func getJobsListWith(provider: Provider, position: Position, url: String){
        DispatchQueue.main.async {
            self.activityIndicator?.startAnimating()
        }
        ApiServiceHandler.shared.getJobsListForProviederAWith(url: url, provider: provider, page: pageCount!) { (list) in
            self.getJobDeatils(list: list, provider: provider, position: position, location: self.location!)
        }
        
    }
    
    func getJobDeatils(list: [Jobs], provider: Provider, position: Position, location: JLocation){
        
        print("completed")
        switch provider{
        case .git:
            print("Git Count: ",list.count)
            if list.count > 0{
                jobs?.append(contentsOf: list)
                for job in list{
                    if !(jobs?.contains(job))!{
                        jobs?.append(job)
                    }
                }
            }
            if isAllProvider!{
                var size = pageCount! * 50
                if size == 0{
                    size = 50
                }
                isAllProvider = false
                self.setupGetJobList(provider: Provider.gov, position: position, location: self.location!)
            }else{
                DispatchQueue.main.async {
                    self.activityIndicator?.stopAnimating()
                    self.tableView.reloadData()
                }
            }
            
        case .gov:
            print("Gov Count: ",list.count)
            
            if list.count > 0{
                jobs?.append(contentsOf: list)
                for job in list{
                    if !(jobs?.contains(job))!{
                        jobs?.append(job)
                    }
                }
                DispatchQueue.main.async {
                    self.activityIndicator?.stopAnimating()
                    self.tableView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    self.activityIndicator?.stopAnimating()
                    self.tableView.reloadData()
                }
            }
        case .all:
            self.setupGetJobList(provider: Provider.gov, position: position, location: self.location!)
        }
    }
    
}

extension ViewController{
    func didCompleteWith(provider: Provider, position: Position, location: JLocation) {
        self.location = location
        jobs?.removeAll()
        currentProvider = provider
        currentPosition = position
        pageCount = 0
        self.setupGetJobList(provider: provider, position: position, location: self.location!)
    }
}

//
//  BaseViewController.swift
//  JobFinder
//
//  Created by Nfonics on 28/06/19.
//  Copyright © 2019 Nfonics. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var activityIndicator: UIActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addActivityIndicatory(uiView: self.view)
    }
    
    func addActivityIndicatory(uiView:UIView){
        //Activity indicator define in Baseviewcontroller can access in anu ViewCotroller
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator?.frame = uiView.bounds
        activityIndicator?.center = uiView.center
        activityIndicator?.hidesWhenStopped = true
        activityIndicator?.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator?.color = .darkGray
        
        // Change background color and alpha channel here
        activityIndicator?.backgroundColor = UIColor.black
        activityIndicator?.clipsToBounds = true
        activityIndicator?.alpha = 0.5
        
        self.navigationController?.view.addSubview(activityIndicator!)
        
    }

}

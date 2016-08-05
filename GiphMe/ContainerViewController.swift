//
//  ContainerViewController.swift
//  GiphMe
//
//  Created by Ian Smith on 8/4/16.
//  Copyright © 2016 Ian Smith. All rights reserved.
//

import UIKit


class ContainerViewController: UIViewController {
    
    var trendingTableView: TrendingTableViewController = TrendingTableViewController()
    var searchTableView: SearchResultsTableViewController = SearchResultsTableViewController()
    
    var currentSegueIdentifier: String = Constants.trendingTableViewSegue
    
    var transitionInProgress: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        transitionInProgress = false
        performSegueWithIdentifier(currentSegueIdentifier, sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == Constants.trendingTableViewSegue) {
            trendingTableView = segue.destinationViewController as! TrendingTableViewController
        }
        
        if (segue.identifier == Constants.searchedTableViewSegue) {
            searchTableView = segue.destinationViewController as! SearchResultsTableViewController
        }
        
        if (segue.identifier == Constants.trendingTableViewSegue) {
            if (childViewControllers.count > 0) {
                swapViewController(self.childViewControllers[0], destinationVC: self.trendingTableView)
            } else {
                addChildViewController(segue.destinationViewController)
                let destView: UIView = segue.destinationViewController.view
                destView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
                destView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)
                self.view.addSubview(destView)
                segue.destinationViewController.didMoveToParentViewController(self)
            }
        } else if (segue.identifier == Constants.searchedTableViewSegue) {
            swapViewController(self.childViewControllers[0], destinationVC: self.searchTableView)
        }
    }
    
    func swapViewController(sourceVC: UIViewController, destinationVC: UIViewController) {
        sourceVC.view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)
        
        sourceVC.willMoveToParentViewController(nil)
        self.addChildViewController(destinationVC)
        
        self.transitionFromViewController(sourceVC, toViewController: destinationVC, duration: 1.0, options: .TransitionCrossDissolve, animations: nil) { (Bool) in
            sourceVC.removeFromParentViewController()
            destinationVC.didMoveToParentViewController(self)
            self.transitionInProgress = false
        }
    }
    
    func swapViewControllers() {
        print("swapped")
                
        if (transitionInProgress) {
            return
        }
        
        transitionInProgress = true
        currentSegueIdentifier = (currentSegueIdentifier == Constants.trendingTableViewSegue) ? Constants.searchedTableViewSegue : Constants.trendingTableViewSegue
        
        if (currentSegueIdentifier == Constants.trendingTableViewSegue) {
            self.swapViewController(trendingTableView, destinationVC: searchTableView)
            return
        }
        
        if (currentSegueIdentifier == Constants.searchedTableViewSegue) {
            self.swapViewController(searchTableView, destinationVC: trendingTableView)
            return
        }
        
        self.performSegueWithIdentifier(currentSegueIdentifier, sender: nil)
    }

}

//
//  ViewController.swift
//  GiphMe
//
//  Created by Ian Smith on 7/22/16.
//  Copyright © 2016 Ian Smith. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet var searchBar: UISearchBar!

    var selectedGifUrl: NSString?
    let containerVC: ContainerViewController = ContainerViewController()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.Portrait]
    }

    // MARK: Search Bar Delegate Methods
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let searchedTerms = searchBar.text?.characters.split{$0 == " "}.map(String.init)
        GiphyClient.searchGiphys(searchedTerms!, completion:{
            let gifUrlString = String(format: "\(DataManager.sharedManager.searchedGifs[0].images!["original"]!["url"])")
            self.selectedGifUrl = gifUrlString
            
            dispatch_async(dispatch_get_main_queue()) {
                self.containerVC.swapViewControllers()
            }
        })
    }
}
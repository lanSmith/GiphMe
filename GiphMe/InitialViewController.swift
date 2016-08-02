//
//  ViewController.swift
//  GiphMe
//
//  Created by Ian Smith on 7/22/16.
//  Copyright © 2016 Ian Smith. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var initialTableView: UITableView!

    var refreshControl = UIRefreshControl()
    let cellReuseIdentifier = "gifCell"
    var selectedGif: UIImage?
    var gifImage: UIImage?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // delegate assignments
        searchBar.delegate = self
        self.initialTableView.delegate = self;
        self.initialTableView.dataSource = self;

        // set up the refresh control
        refreshControl.attributedTitle = NSAttributedString(string: "pull for most up to date trendist memes. doooo ittttttt")
        refreshControl.addTarget(self, action:#selector(self.refresh(_:)) , forControlEvents: UIControlEvents.ValueChanged)
        initialTableView?.addSubview(refreshControl)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.Portrait]
    }

    // MARK: Search Bar Delegate Methods
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let searchedTerms = searchBar.text?.characters.split{$0 == " "}.map(String.init)
        GiphyClient.searchGiphys(searchedTerms!)
    }

    // MARK: TableView DataSource & Delegate Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.sharedManager.trendingGifs.count
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0;
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "...::|   TRENDING   |::..."
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = initialTableView.dequeueReusableCellWithIdentifier("cellId")!

        let urlString = String(format: "\(DataManager.sharedManager.trendingGifs[indexPath.row].images!["original_still"]!["url"])")
        let gifUrl = NSURL(string: urlString)

        GiphyClient.getGiphyImageAtAddress(gifUrl!) { image in
            self.gifImage = image!
            let gifView: UIImageView = UIImageView.init(image: image)
            gifView.contentMode = .ScaleAspectFill
            gifView.frame = cell.bounds
            cell.addSubview(gifView)
        }

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let urlString = String(format: "\(DataManager.sharedManager.trendingGifs[indexPath.row].images!["original"]!["url"])")
        let gifUrl = NSURL(string: urlString)
        
        GiphyClient.getGiphyImageAtAddress(gifUrl!) { image in
            self.selectedGif = image
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("SegueToGifViewer", sender: self)
            }
        }
    }

    func refresh(sender:AnyObject) {
        if self.refreshControl.refreshing {
            self.refreshControl.endRefreshing()
        }

        initialTableView.reloadData()
    }

    // Segue Crap
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Segue \(segue)")
        if segue.identifier == "SegueToGifViewer" {
            if let gifViewer = segue.destinationViewController as? GifViewerViewController {
                gifViewer.gif = selectedGif!
            }
        }
    }
}
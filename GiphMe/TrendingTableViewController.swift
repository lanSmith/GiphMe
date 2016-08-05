//
//  TrendingTableViewController.swift
//  GiphMe
//
//  Created by Ian Smith on 8/4/16.
//  Copyright © 2016 Ian Smith. All rights reserved.
//

import UIKit

class TrendingTableViewController: UITableViewController {
    
    var refresh = UIRefreshControl()
    
    let cellReuseIdentifier = "gifCell"
    
    var selectedGifUrl: NSString?
    var gifImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh.attributedTitle = NSAttributedString(string: "pull for most up to date trendist memes. doooo ittttttt")
        refresh.addTarget(self, action:#selector(self.refresh(_:)) , forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refresh)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func refresh(sender:AnyObject) {
        print("reloading")
        tableView.reloadData()
        
        
        if self.refresh.refreshing {
            self.refresh.endRefreshing()
        }
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.sharedManager.trendingGifs.count
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0;
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "...::|   TRENDING   |::..."
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("TrendingCell")!
        
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let gifUrlString = String(format: "\(DataManager.sharedManager.trendingGifs[indexPath.row].images!["original"]!["url"])")
        selectedGifUrl = gifUrlString
        
        dispatch_async(dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("SegueToGifViewer", sender: nil)
        }
    }
    
    // Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SegueToGifViewer" {
            if let gifViewer = segue.destinationViewController as? GifViewerViewController {
                gifViewer.gifUrl = selectedGifUrl!
            }
        }
    }
}

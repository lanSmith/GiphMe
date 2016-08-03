//
//  GifViewerViewController.swift
//  GiphMe
//
//  Created by Ian Smith on 7/29/16.
//  Copyright © 2016 Ian Smith. All rights reserved.
//

import Foundation
import UIKit
import SwiftGifOrigin

class GifViewerViewController : UIViewController {

    @IBOutlet var fullScreenImageView: UIImageView!
    
    var gifUrl: NSString = ""
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        fullScreenImageView.contentMode = .ScaleAspectFit
        fullScreenImageView.image = UIImage.gifWithURL(gifUrl as String)
    }
        
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {    
        return UIInterfaceOrientation.Portrait;
    }
    
    override func shouldAutorotate() -> Bool {
        return true;
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    @IBAction func closeTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
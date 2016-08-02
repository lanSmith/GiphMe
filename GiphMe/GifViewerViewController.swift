//
//  GifViewerViewController.swift
//  GiphMe
//
//  Created by Ian Smith on 7/29/16.
//  Copyright © 2016 Ian Smith. All rights reserved.
//

import Foundation
import UIKit

class GifViewerViewController : UIViewController {

    @IBOutlet var fullScreenImageView: UIImageView!
    var gif: UIImage = UIImage.init()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        fullScreenImageView.contentMode = .ScaleAspectFit
        fullScreenImageView.image = gif
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
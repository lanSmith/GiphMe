//
//  LiveCameraView.swift
//  GiphMe
//
//  Created by Ian Smith on 7/22/16.
//  Copyright © 2016 Ian Smith. All rights reserved.
//

import UIKit

class LiveCameraView: UIView {

        override init(frame: CGRect) {
            super.init(frame: frame)

            self.initialize()
        }

        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)!

            self.initialize()
        }

        convenience init() {
            self.init(frame: CGRectZero)

            self.initialize()
        }
        
        func initialize() {
            
        }
}
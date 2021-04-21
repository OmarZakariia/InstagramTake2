//
//  Extension.swift
//  Instagram 2
//
//  Created by Omar Zakaria on /204/21.
//

import UIKit
/// This extension is for writing shorthand syntax extensions that I will use throughout the project

extension UIView{
    public var width : CGFloat{
        // now I can go to login VC and, headerView.frame. ~~ and use view.width (view.width is the one I created in the extension
        return frame.size.width
    }
    public var height : CGFloat{
        return frame.size.height
    }
    public var top : CGFloat{
        return frame.origin.y
    }
    public var bottom : CGFloat{
        return frame.origin.y + frame.size.height
    }
    public var left: CGFloat{
        return frame.origin.x
    }
    
    public var right: CGFloat{
        return frame.origin.x + frame.size.width
    }
    
}

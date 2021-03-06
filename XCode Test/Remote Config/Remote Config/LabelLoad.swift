//
//  LabelLoad.swift
//  Remote Config
//
//  Created by Timothy Barnard on 23/10/2016.
//  Copyright © 2016 Timothy Barnard. All rights reserved.
//

import UIKit

protocol LabelLoad {}

public enum SKNSTextAlignment : Int {
    
    
    case left // Visually left aligned
    
    
    case center // Visually centered
    
    case right // Visually right aligned
    
    /* !TARGET_OS_IPHONE */
    // Visually right aligned
    // Visually centered
    
    case justified // Fully-justified. The last line in a paragraph is natural-aligned.
    
    case natural // Indicates the default alignment for script
}

extension LabelLoad where Self: UILabel {
    
    func setupLabelView( className: UIViewController, name: String = "") {
       self.setup(className: String(describing: type(of: className)), tagValue: name)
    }
    
    func setupLabelView( className: UIView, name: String = "") {
        self.setup(className: String(describing: type(of: className)), tagValue: name)
    }
    
    private func setup( className: String, tagValue : String ) {
        
        var viewName = ""
        if tagValue.isEmpty {
            viewName = String(self.tag)
        }
        
        let dict = RCConfigManager.getObjectProperties(className: className, objectName: viewName)
        
        var fontName: String = ""
        var size : CGFloat = 0.0
        for (key, value) in dict {
            
            switch key {
            case "text":
                self.text = value as? String
                break
            case "textAlignment":
                self.textAlignment = NSTextAlignment(rawValue: (value as! Int))!
            case "backgroundColor":
                self.backgroundColor = RCFileManager.readJSONColor(keyVal: value as! String)
                break
            case "font":
                fontName = (value as! String)
                break
            case "fontSize":
                size = value as! CGFloat
                break
            case "textColor":
                self.textColor = RCFileManager.readJSONColor(keyVal: value as! String)
                break
            case "isEnabled":
                self.isEnabled = ((value as! Int)  == 1) ? true : false
                break
            case "isHidden":
                self.isHidden = ((value as! Int)  == 1) ? true : false
                break
            case "isUserInteractionEnabled":
                self.isUserInteractionEnabled = ((value as! Int)  == 1) ? true : false
                break
            default: break
            }
        }
        self.font = UIFont(name: fontName, size: size)
    }

    
}

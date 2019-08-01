//
//  SwiftIcon.swift
//  Players' Post
//
//  Created by Eric Yang on 1/8/19.
//  Copyright © 2019 TPT. All rights reserved.
//

import Foundation
import CoreGraphics
import CoreText
import UIKit

public class SwiftIcon {
    static var fontFileName: String?
    static var fontFileExtension: String?
    static var bundle: Bundle?
    
    /// fontFileName:  the file name of the font file
    /// fontFileExtension: the file extension of the font file, using "tff" as default
    /// bundle: The sepecific bundle, using main bundle as default
    public class func registFontAsIcon(_ fontFileName: String, _ fontFileExtension: String = "tff", _ bundle: Bundle = Bundle.main) {
        SwiftIcon.initialize(fontFileName, fontFileExtension, bundle)
    }
    
    private class func initialize(_ fontFileName: String, _ fontFileExtension: String, _ bundle: Bundle) {
        self.fontFileName = fontFileName
        self.fontFileExtension = fontFileExtension
        self.bundle = bundle
    }
    
    fileprivate class func registerFont() {
        guard let fontFileName = SwiftIcon.fontFileName else {
            print("SwiftIcon+: Font file name for resource was not found.")
            return
        }
        
        guard let fontFileExtension = SwiftIcon.fontFileExtension else {
            print("SwiftIcon+: Font file extension for resource was not found.")
            return
        }
        
        guard let pathForResourceURL = bundle?.url(forResource: fontFileName, withExtension: fontFileExtension) else {
            print("SwiftIcon+: Font file path for resource was not found.")
            return
        }
        
        guard let fontData = NSData(contentsOfFile: pathForResourceURL.absoluteString) else {
            print("SwiftIcon+: Font data could not be loaded.")
            return
        }
        
        guard let dataProvider = CGDataProvider(data: fontData) else {
            print("SwiftIcon+: Fata provider could not be loaded.")
            return
        }
        
        guard let font = CGFont(dataProvider) else {
            print("SwiftIcon+: Font could not be loaded.")
            return
        }
        
        var errorRef: Unmanaged<CFError>? = nil
        if (CTFontManagerRegisterGraphicsFont(font, &errorRef) == false) {
            print("SwiftIcon+: Register graphics font failed")
        }
    }
}

extension UIFont {
    class func fontWithSize(_ size: CGFloat) -> UIFont? {
        guard let name = SwiftIcon.fontFileName else {
            print("SwiftIcon+: Please setup fontname before using")
            return nil
        }
        
        if let font = self.init(name: name, size: size) {
            return font
        }else {
            SwiftIcon.registerFont()
            guard let font = self.init(name: name, size: size) else {
                print("SwiftIcon+: Can't find the desired font")
                return nil
            }
            
            return font
        }
    }
}

public extension String {
    fileprivate static func iconName(from code: String) -> String? {
        if let charAsInt = Int(code, radix: 16),
            let uScalar = UnicodeScalar(charAsInt) {
            return String(uScalar)
        }
        
        return nil
    }
    
    /// code: the hexadecimal code of the font, like: "e929"
    /// size: the size of the icon, currently it's a square icon
    /// color: the icon's color
    static func icon(_ code: String, _ size: CGFloat, color: UIColor) -> NSAttributedString? {
        guard let iconName = String.iconName(from: code), let font = UIFont.fontWithSize(size) else {
            return nil
        }
        let textFontAttributes: [NSAttributedString.Key : Any] = [
            .font: font,
            .foregroundColor: color
        ]
        let attributtedText = NSAttributedString(string: iconName, attributes: textFontAttributes)
        return attributtedText
    }
}

public extension UIImage {
    /// code: the hexadecimal code of the font, like: "e929"
    /// size: the size of the icon, currently it's a square icon
    /// color: the icon's color
    /// backgroundColor: the background of the icon image, default is clear
    /// inset: offest of the icon at the iamge, zero is the defaul
    class func icon(_ code: String, _ size: CGFloat, color: UIColor, backgroundColor: UIColor = .clear, inset: UIEdgeInsets = UIEdgeInsets.zero) -> UIImage? {
        return UIImage.generateImage(code, size, color: color, backgroundColor: backgroundColor, inset: inset)
    }
    
    private class func generateImage(_ code: String, _ size: CGFloat, color: UIColor, backgroundColor: UIColor = .clear, inset: UIEdgeInsets) -> UIImage? {
        let width = size - inset.left - inset.right
        let height = size - inset.top - inset.bottom
        let iconSize = min(width, height)
        let imageSize = size
        
        guard let attributtedText = String.icon(code, iconSize, color: color) else {
            return nil
        }
        
        let scale = UIScreen.main.scale
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: size, height: size), false, scale)
        
        if backgroundColor != .clear {
            backgroundColor.set()
            UIRectFill(CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        }
        
        let point = CGPoint(x: inset.left, y: inset.top)
        attributtedText.draw(at: point)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

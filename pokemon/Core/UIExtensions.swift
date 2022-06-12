//
//  UIExtensions.swift
//  wheatherApp
//
//  Created by sara salem on 06/05/2022.
//

import UIKit

extension UIViewController{
    
    func showAlert(error: Error) {
        let controller = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))

        present(controller, animated: true, completion: nil)
    }
    func showAlert(error: String) {
        let controller = UIAlertController(title: "Something went wrong", message: error, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        present(controller, animated: true, completion: nil)
    }
}

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func mainPink() -> UIColor {
        return UIColor.rgb(red: 221, green: 94, blue: 86)
    }
    
    static var appTheme:UIColor{
        return UIColor(red: 167/255, green: 133/255, blue: 171/255, alpha: 1)//UIColor(red: 109/255, green: 142/255, blue: 233/255, alpha: 1)
    }
    
}

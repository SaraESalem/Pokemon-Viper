//
//  SceneDelegate.swift
//  pokemon
//
//  Created by sara salem on 29/05/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        clearNavCIOS15()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: SpeciesListRouter.createModule())
    
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
    func clearNavCIOS15(){
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.appTheme
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,.font:UIFont.systemFont(ofSize: 25, weight: .medium)]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}


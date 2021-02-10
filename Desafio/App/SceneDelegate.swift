//
//  SceneDelegate.swift
//  Desafio
//
//  Created by miguel.horta.nery on 09/02/21.
//  Copyright © 2021 miguel.horta.nery. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.windowScene = windowScene
        window.rootViewController = MovieListViewController()
        window.makeKeyAndVisible()
        self.window = window
    }
}


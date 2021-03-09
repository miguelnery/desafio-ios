//
//  AppDelegate.swift
//  Desafio
//
//  Created by miguel.horta.nery on 09/02/21.
//  Copyright © 2021 miguel.horta.nery. All rights reserved.
//

import UIKit
import Combine

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let hueLoader = HueLoader()
    let movieLoader = MovieLoader()
    var sub: AnyCancellable?

    deinit {
        print("deinit appdelegate⛔️⛔️⛔️⛔️⛔️⛔️⛔️⛔️⛔️⛔️⛔️⛔️⛔️")
    }

    func applicationDidFinishLaunching(_ application: UIApplication) {
        sub = movieLoader
            .loadPopular()
            .flatMap(hueLoader.makeViewModels(from:))
            .sink(receiveCompletion: { completion in print(completion) },
                  receiveValue: { results in print(results) })
    }
}


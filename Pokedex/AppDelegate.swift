//
//  AppDelegate.swift
//  Pokedex
//
//  Created by João Jacó Santos Abreu on 29/09/20.
//  Copyright © 2020 João Jacó Santos Abreu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        let service = HomeScreenService()
//        service.fetchPokemonUrlList { result in
//            switch result {
//            case .success(let data):
//                service.fetchPokemon(with: data.results[1].url) { result in
//                    switch result {
//                    case .success(let pokemon):
//                        print(pokemon)
//                    case .failure(let err):
//                        print(err.localizedDescription)
//                    }
//                }
//            case .failure(let err):
//                print(err.localizedDescription)
//            }
//        }
        let viewModel = HomeScreenViewModel()
        viewModel.fetchPokemonUrlList()
        return true
    }

}


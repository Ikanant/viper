//
//  Router.swift
//  viper
//
//  Created by Jonathan Hernandez on 5/11/22.
//

import Foundation

// VIPER assumes there will be different Modules in my application
// Router will be able to route within it's own module
// Consider if my app has 5 tabs... each tab it's potentially a  module

// It DOES NOT have a reference to anything else
// It is the ENTRY POINT for my module. This is where the VIPER architecture starts
// This is the entrance to our ViewController 

protocol AnyRouter {
    // Will return AnyRouter
    static func start() -> AnyRouter
}

// Only named user because the API end point I will start pointing us too will just return a list of users
class UserRouter: AnyRouter {
    // Here is where I am going to create all of the components of VIPER and return them
    static func start() -> AnyRouter {
        let router = UserRouter()
        
        // Assign VIP (view-interactor-presenter)
        
        return router
    }
}

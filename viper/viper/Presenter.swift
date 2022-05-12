//
//  Presenter.swift
//  viper
//
//  Created by Jonathan Hernandez on 5/11/22.
//

import Foundation

// The Object that ties EVERYTHING together
// Has references to the INTERACTOR, ROUTER and the VIEW itself
// The PRESENTER is what tells the view what to do

protocol AnyPresenter {
    // Needs to have a reference to an Interactor, Router and View
    // ? - Remember just means they are optional
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    // Will also need some functions...
    // So, the interactor NEEDS to tell the presenter when some interaction just occurred.
    // We will need a single function that the Interactor can call
    func interactorDidFetchUsers(with result: Result<[User], Error>)
}

class UserPresenter: AnyPresenter {
    var interactor: AnyInteractor?
    
    var view: AnyView?
    
    var router: AnyRouter?
    
    func interactorDidFetchUsers(with result: Result<[User], Error>) {
        
    }
}

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

// Let's create an ENUM with all the possible errors I might encounter:
enum FetchError: Error {
    case failed // Meh, I only need one
}

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
    var interactor: AnyInteractor? {
        // Once an instance of the interactor is set, run the closure!
        didSet {
            interactor?.getUsers()
        }
    }
    
    var view: AnyView?
    
    var router: AnyRouter?
    
    // Now it's time to load some data...
    // I can have the VIEW go and fetch the data, but that defeats the point of using the VIPER architecture...
    // I could have the router... but even then, the right way to do it is have the Interactor take care of the data loading interaction... which would then notify the presenter, which would then just reflect the change to the View
    init () {
        interactor?.getUsers() // THIS WILL NOT WORK because by the time we instantiate the PRESENTER before the Interactor is actually set... this is where the DidSet comes in handy
    }
    
    func interactorDidFetchUsers(with result: Result<[User], Error>) {
        switch (result) {
        case .success(let users):
            view?.update(with: users)
        case .failure :
            view?.update(with: "MY ERROR: SOMETHING WENT NO BUENO")
        }
    }
}

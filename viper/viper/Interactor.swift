//
//  Interactor.swift
//  viper
//
//  Created by Jonathan Hernandez on 5/11/22.
//

import Foundation

// Object
// Should only have a reference to the PRESENTER
// Interactor's job is to go get data or perform some type of interaction...
// When the task is completed, the Interactor will just feed back the result to the PRESENTER

// I will be adding an API call through the Interactor
protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    // No completion handlers needed
    // The interactor will inform the presenter once it's ready
    func getUsers()
}

class UserInteactor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUsers() {
        
    }
}

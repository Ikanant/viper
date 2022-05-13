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

class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUsers() {
        // This is where I will have a basic API call
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) {
            // Closure time:
            // Fun syntax as I have written in my Swift notes...
            // REFERENCE: func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
            // I care to grab the data, but not the urlResponse... I will also grab the error in case there is one:
            [weak self] data, _, error in // WEAK SELF is a way to avoid memory leaks
            
            // Recall that guard will serve to make sure a set of conditionals are met, and if not... bail
            guard let data = data, error == nil else {
                // Return error if things did not load properly...
                // IMPORTANT NOTE: Reference to property 'presenter' in closure requires explicit use of 'self' to make capture semantics explicit
                
                
                // ALSO, notice the input for the interactorDidFetchUsers function... is of type Swift.Result which is an enum with two types: failure/success
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                
                // REFERENCE: func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
                // note: use '.self' to reference the type object
                let response = try jsonDecoder.decode([User].self, from: data)
                
                // Now if we have a response (IN OTHER WORDS THE ENTITIES WE WANT)
                // We can just return a .success
                self?.presenter?.interactorDidFetchUsers(with: .success(response))
            }
            catch {
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
            }
        }
        
        // This task will ONLY run when we trigger the task.resume() function
        task.resume()
    }
}

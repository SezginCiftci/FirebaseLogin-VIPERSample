//
//  SignUpPresenter.swift
//  FirebaseLogin
//
//  Created by Sezgin on 2.05.2022.
//

import Foundation

protocol SignUpPresenterProtocol: AnyObject {
    func notifyCreateUserButtonTapped(username: String, password: String)
    func userCreateNotSuccess()
    func userCreateSuccess()
    func routeToMain()
}

class SignUpPresenter: SignUpPresenterProtocol {
    weak var view: SignUpViewProtocol?
    var interactor: SignUpInteractorProtocol?
    var router: SignUpRouterProtocol?
    
    func notifyCreateUserButtonTapped(username: String, password: String) {
        interactor?.didCreateUser(username: username, password: password)
    }
    
    func userCreateSuccess() {
        view?.userCreated()
    }
    
    func userCreateNotSuccess() {
        view?.userNotCreated()
    }
    
    func routeToMain() {
        router?.routeToMain()
    }
}

//
//  
//  MainRouter.swift
//  Currency Converter
//
//  Created by Misael on 22/09/23.
//
//

import Foundation
import UIKit

class MainRouter: MainRouterProtocol {
    
    static func createModule() -> UIViewController {
        let view = MainView()
        let presenter: MainPresenterProtocol & MainInteractorOutputProtocol = MainPresenter()
        let interactor: MainInteractorInputProtocol = MainInteractor()
        let router: MainRouterProtocol = MainRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}

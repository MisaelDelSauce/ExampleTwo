//
//  
//  MainProtocols.swift
//  Currency Converter
//
//  Created by Misael on 22/09/23.
//
//

import Foundation
import UIKit

protocol MainViewProtocol: AnyObject {
    var presenter: MainPresenterProtocol? { get set }
    
    func getRatesSuccess(rates: Rates)
    func getRatesFailure(error: String)
}

protocol MainPresenterProtocol: AnyObject {
    var view: MainViewProtocol? { get set }
    var interactor: MainInteractorInputProtocol? { get set }
    var router: MainRouterProtocol? { get set }
    
    func getRates()
}

protocol MainInteractorInputProtocol: AnyObject {
    var presenter: MainInteractorOutputProtocol? { get set }
    
    func onRequestGetRates()
}

protocol MainInteractorOutputProtocol: AnyObject {
    func onResponseGetRatesSuccess(rates: Rates)
    func onResponseGetRatesFailure(error: String)
}

protocol MainRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

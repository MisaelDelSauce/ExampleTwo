//
//  
//  MainPresenter.swift
//  Currency Converter
//
//  Created by Misael on 22/09/23.
//
//

import Foundation

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    var interactor: MainInteractorInputProtocol?
    var router: MainRouterProtocol?
    
    func getRates() {
        interactor?.onRequestGetRates()
    }
}

extension MainPresenter: MainInteractorOutputProtocol {
    func onResponseGetRatesSuccess(rates: Rates) {
        view?.getRatesSuccess(rates: rates)
    }
    
    func onResponseGetRatesFailure(error: String) {
        view?.getRatesFailure(error: error)
    }
}

//
//  
//  MainInteractor.swift
//  Currency Converter
//
//  Created by Misael on 22/09/23.
//
//

import Foundation

class MainInteractor: MainInteractorInputProtocol {
    weak var presenter: MainInteractorOutputProtocol?
    
    func onRequestGetRates() {
        var apiConfig = APIConfig(url: EndPoints.rates, httpMethod: .GET)
        let apiManager = APIManager()
        
        apiConfig.params = ["access_key": "be420cca0f2f211c4e723ffb7ccaf06a"]
    
        let api = API(apiConfig: apiConfig, apiManager: apiManager)
        
        api.fetch{ (result: Result<Rates, HTTPError>) in
            switch result {
            case .success(let ratesResponse):
                if let error = ratesResponse.error {
                    self.presenter?.onResponseGetRatesFailure(error: error.info ?? "")
                } else {
                    self.presenter?.onResponseGetRatesSuccess(rates: ratesResponse)
                }
            case .failure(let error):
                self.presenter?.onResponseGetRatesFailure(error: error.localizedDescription)
            }
        }
    }
}

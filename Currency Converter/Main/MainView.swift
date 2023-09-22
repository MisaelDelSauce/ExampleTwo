//
//  
//  MainView.swift
//  Currency Converter
//
//  Created by Misael on 22/09/23.
//
//

import UIKit

class MainView: UIViewController {
    
    private lazy var rateOneLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rateTwoLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rateThreeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rateFourLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rateFiveLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratesBtn: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(getRatesClicked), for: .touchUpInside)
        button.setTitle("Get rates", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 20
        return button
    }()
    
    private lazy var note: UILabel = {
        let label = UILabel(frame: .zero)
        label .translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "NOTA: Quise usar el siguiente endpoint para convertir HNL a cualquier moneda\n\n http://data.fixer.io/api/convert?access_key=be420cca0f2f211c4e723ffb7ccaf06a&from=HNL&to=JPY&amount=25 \n\npero la cuenta gratuita no da soporte a este endpoint\n\n{success:false,error:{code:105,type:function_access_restricted,info:Access Restricted - Your current Subscription Plan does not support this API Function.}}"
        label.textAlignment = .center
        return label
    }()
    
    var presenter: MainPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Currency Converter"
        setupView()
        setupAutoLayout()
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(rateOneLabel)
        view.addSubview(rateTwoLabel)
        view.addSubview(rateThreeLabel)
        view.addSubview(rateFourLabel)
        view.addSubview(rateFiveLabel)
        view.addSubview(ratesBtn)
        view.addSubview(note)
    }
    
    func setupAutoLayout() {
        let view = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            rateOneLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            rateOneLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            rateTwoLabel.topAnchor.constraint(equalTo: rateOneLabel.bottomAnchor, constant: 20),
            rateTwoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            rateThreeLabel.topAnchor.constraint(equalTo: rateTwoLabel.bottomAnchor, constant: 20),
            rateThreeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            rateFourLabel.topAnchor.constraint(equalTo: rateThreeLabel.bottomAnchor, constant: 20),
            rateFourLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            rateFiveLabel.topAnchor.constraint(equalTo: rateFourLabel.bottomAnchor, constant: 20),
            rateFiveLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            ratesBtn.topAnchor.constraint(equalTo: rateFiveLabel.bottomAnchor, constant: 40),
            ratesBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ratesBtn.heightAnchor.constraint(equalToConstant: 40),
            ratesBtn.widthAnchor.constraint(equalToConstant: 100),
            
            note.topAnchor.constraint(equalTo: ratesBtn.bottomAnchor, constant: 40),
            note.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            note.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    @objc func getRatesClicked() {
        presenter?.getRates()
    }
}

extension MainView: MainViewProtocol {
    func getRatesSuccess(rates: Rates) {
        DispatchQueue.main.async {
            self.rateOneLabel.text = "USD : \(rates.rates?.usd ?? 0.0)"
            self.rateTwoLabel.text = "CAD : \(rates.rates?.cad ?? 0.0)"
            self.rateThreeLabel.text = "MXN : \(rates.rates?.mxn ?? 0.0)"
            self.rateFourLabel.text = "EUR : \(rates.rates?.eur ?? 0.0)"
            self.rateFiveLabel.text = "JPY : \(rates.rates?.jpy ?? 0.0)"
        }
    }
    
    func getRatesFailure(error: String) {
        
    }
}

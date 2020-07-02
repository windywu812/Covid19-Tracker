//
//  ViewController.swift
//  Programmatically
//
//  Created by Windy on 17/06/20.
//  Copyright © 2020 Windy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var covids: Covid?
    
    var countryLabel: UILabel!
    var numberNewCaseLabel: UILabel!
    var numberTotalCaseLabel: UILabel!
    var numberRecoverLabel: UILabel!
    var numberDeathLabel: UILabel!
    
    var numberGlobalInfectedLabel: UILabel!
    var numberGlobalRecoverLabel: UILabel!
    var numberGlobalDeathLabel: UILabel!
    
    var countriesPicker: UIPickerView!
    var isOnPicker: Bool = false
    
    var globalContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        ApiServices().fetchRequest { (dataCovid) in
            self.covids = dataCovid
            
            DispatchQueue.main.async {
                self.numberGlobalInfectedLabel.numberFormatter(self.covids?.global.totalInfected ?? 0)
                self.numberGlobalRecoverLabel.numberFormatter(self.covids?.global.totalRecovered ?? 0)
                self.numberGlobalDeathLabel.numberFormatter(self.covids?.global.totalDeath ?? 0)

                self.countryLabel.text = "\(self.covids?.countries[0].country ?? "")"
                self.numberNewCaseLabel.numberFormatter(self.covids?.countries[0].newConfirmed ?? 0)
                self.numberTotalCaseLabel.numberFormatter(self.covids?.countries[0].totalConfirmed ?? 0)
                self.numberRecoverLabel.numberFormatter(self.covids?.countries[0].totalRecovered ?? 0)
                self.numberDeathLabel.numberFormatter(self.covids?.countries[0].totalDeath ?? 0)
            }
        }
    }

    override func loadView() {
        super.loadView()
        
        view.backgroundColor = UIColor(named: "blue")
        
        topView()
        bottomContainer()
        setPickerView()
    }
    
    private func topView() {
        
        let titleLabel = UILabel()
        titleLabel.text = "Covid 19 Tracker"
        titleLabel.font = UIFont(name: "AvenirNext-Bold", size: 28)
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        
        let descriptonLabel = UILabel()
        descriptonLabel.text = "Remember to stay at home"
        descriptonLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        descriptonLabel.textColor = .black
        view.addSubview(descriptonLabel)
        
        descriptonLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptonLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        descriptonLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true

        let imageView = UIImageView()
        imageView.image = UIImage(named: "human")
        view.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true

        let circleOne = UIImageView()
        circleOne.image = UIImage(named: "circle")
        view.addSubview(circleOne)

        circleOne.translatesAutoresizingMaskIntoConstraints = false
        circleOne.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        circleOne.topAnchor.constraint(lessThanOrEqualTo: descriptonLabel.bottomAnchor, constant: 28).isActive = true
        
        let circleTwo = UIImageView()
        circleTwo.image = UIImage(named: "circle")
        view.addSubview(circleTwo)

        circleTwo.translatesAutoresizingMaskIntoConstraints = false
        circleTwo.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -20).isActive = true
        circleTwo.topAnchor.constraint(lessThanOrEqualTo: descriptonLabel.bottomAnchor, constant: 64).isActive = true

        let circleThree = UIImageView()
        circleThree.image = UIImage(named: "circle")
        view.addSubview(circleThree)

        circleThree.translatesAutoresizingMaskIntoConstraints = false
        circleThree.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28).isActive = true
        circleThree.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        
    }
    
    private func bottomContainer() {
        
        // MARK: Container View
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 30
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.addSubview(containerView)
        
        containerView.activeAutoLayout()
        containerView.setLeadingAnchor(view.leadingAnchor, constant: 0)
        containerView.setTrailingAnchor(view.trailingAnchor, constant: 0)
        containerView.setBottomAnchor(view.bottomAnchor, constant: 0)
        containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 275).isActive = true
        
        // MARK: Country Label
        countryLabel = UILabel()
        countryLabel.text = "Indonesia"
        countryLabel.font = UIFont(name: "AvenirNext-Demibold", size: 20)
        countryLabel.textColor = .black
        countryLabel.isUserInteractionEnabled = true
        countryLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moreCountry)))
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = UIColor.black
        button.addTarget(self, action: #selector(moreCountry), for: .touchUpInside)
        
        let regionStackView = UIStackView()
        regionStackView.axis = .horizontal
        regionStackView.addArrangedSubview(countryLabel)
        regionStackView.addArrangedSubview(button)
        containerView.addSubview(regionStackView)

        regionStackView.translatesAutoresizingMaskIntoConstraints = false
        regionStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24).isActive.toggle()
        regionStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        
        // MARK: New Case Container
        let newCaseContainer = UIView()
        newCaseContainer.backgroundColor = .white
        newCaseContainer.clipsToBounds = true
        newCaseContainer.layer.cornerRadius = 20
        newCaseContainer.addShadow()
        containerView.addSubview(newCaseContainer)
        
        newCaseContainer.translatesAutoresizingMaskIntoConstraints = false
        newCaseContainer.topAnchor.constraint(equalTo: regionStackView.bottomAnchor, constant: 16).isActive = true
        newCaseContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        newCaseContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 183).isActive = true
        newCaseContainer.heightAnchor.constraint(equalTo: newCaseContainer.widthAnchor, multiplier: 1).isActive = true
        newCaseContainer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        newCaseContainer.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        let newCaseLabel = UILabel()
        newCaseLabel.text = "New Case"
        newCaseLabel.font = UIFont(name: "AvenirNext-Demibold", size: 20)
        newCaseLabel.textColor = UIColor(named: "yellow")

        numberNewCaseLabel = UILabel()
        numberNewCaseLabel.text = "1,313"
        numberNewCaseLabel.font = UIFont(name: "AvenirNext-Bold", size: 34)
        numberNewCaseLabel.textColor = UIColor(named: "yellow")
        
        let newCaseStackView = UIStackView()
        newCaseStackView.axis = .vertical
        newCaseStackView.alignment = .center
        newCaseStackView.spacing = 16
        newCaseStackView.addArrangedSubview(newCaseLabel)
        newCaseStackView.addArrangedSubview(numberNewCaseLabel)
        containerView.addSubview(newCaseStackView)
        
        newCaseStackView.translatesAutoresizingMaskIntoConstraints = false
        newCaseStackView.setToCenter(newCaseContainer)
        
        // MARK: Total Case Container
        let totalCaseContainer = UIView()
        totalCaseContainer.backgroundColor = .white
        totalCaseContainer.clipsToBounds = true
        totalCaseContainer.layer.cornerRadius = 20
        totalCaseContainer.addShadow()
        containerView.addSubview(totalCaseContainer)

        totalCaseContainer.translatesAutoresizingMaskIntoConstraints = false
        totalCaseContainer.topAnchor.constraint(equalTo: regionStackView.bottomAnchor, constant: 16).isActive.toggle()
        totalCaseContainer.leadingAnchor.constraint(equalTo: newCaseContainer.trailingAnchor, constant: 16).isActive.toggle()
        totalCaseContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive.toggle()
        totalCaseContainer.widthAnchor.constraint(equalTo: newCaseContainer.widthAnchor, multiplier: 1).isActive = true
        totalCaseContainer.heightAnchor.constraint(equalTo: totalCaseContainer.widthAnchor, multiplier: 1).isActive = true
        
        let totalCaseLabel = UILabel()
        totalCaseLabel.text = "Total Case"
        totalCaseLabel.font = UIFont(name: "AvenirNext-Demibold", size: 20)
        totalCaseLabel.textColor = .black
        
        numberTotalCaseLabel = UILabel()
        numberTotalCaseLabel.font = UIFont(name: "AvenirNext-Bold", size: 34)
        numberTotalCaseLabel.text = "42,762"
        numberTotalCaseLabel.textColor = .black
        
        let totalCaseStackView = UIStackView()
        totalCaseStackView.axis = .vertical
        totalCaseStackView.spacing = 16
        totalCaseStackView.alignment = .center
        totalCaseStackView.addArrangedSubview(totalCaseLabel)
        totalCaseStackView.addArrangedSubview(numberTotalCaseLabel)
        containerView.addSubview(totalCaseStackView)
        
        totalCaseStackView.activeAutoLayout()
        totalCaseStackView.setToCenter(totalCaseContainer)
        
        // MARK: Recover Container
        let recoverContainer = UIView()
        recoverContainer.clipsToBounds = true
        recoverContainer.layer.cornerRadius = 20
        recoverContainer.backgroundColor = .white
        recoverContainer.addShadow()
        containerView.addSubview(recoverContainer)
        
        recoverContainer.activeAutoLayout()
        recoverContainer.topAnchor.constraint(equalTo: newCaseContainer.bottomAnchor, constant: 16).isActive = true
        recoverContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        recoverContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 183).isActive = true
        recoverContainer.heightAnchor.constraint(lessThanOrEqualToConstant: 103).isActive = true
        recoverContainer.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        recoverContainer.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        // MARK: Recover Label
        let recoverLabel = UILabel()
        recoverLabel.text = "Recover"
        recoverLabel.textColor = UIColor(named: "green")
        recoverLabel.setDemiboldFont(17)
        numberRecoverLabel = UILabel()
        numberRecoverLabel.text = "16,798"
        numberRecoverLabel.textColor = UIColor(named: "green")
        numberRecoverLabel.font = UIFont(name: "AvenirNext-Bold", size: 28)
        
        let recoverStackView = UIStackView()
        recoverStackView.axis = .vertical
        recoverStackView.alignment = .center
        recoverStackView.spacing = 8
        recoverStackView.addArrangedSubview(recoverLabel)
        recoverStackView.addArrangedSubview(numberRecoverLabel)
        recoverContainer.addSubview(recoverStackView)
        recoverStackView.activeAutoLayout()
        recoverStackView.setToCenter(recoverContainer)
        
        // MARK: Recover Death
        let deathContainer = UIView()
        deathContainer.clipsToBounds = true
        deathContainer.layer.cornerRadius = 20
        deathContainer.backgroundColor = .white
        deathContainer.addShadow()
        containerView.addSubview(deathContainer)
        
        deathContainer.activeAutoLayout()
        deathContainer.topAnchor.constraint(equalTo: totalCaseContainer.bottomAnchor, constant: 16).isActive = true
        deathContainer.leadingAnchor.constraint(equalTo: recoverContainer.trailingAnchor, constant: 16).isActive = true
        deathContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
        deathContainer.widthAnchor.constraint(equalTo: recoverContainer.widthAnchor, multiplier: 1).isActive = true
        deathContainer.heightAnchor.constraint(equalTo: recoverContainer.heightAnchor, multiplier: 1).isActive = true

        // MARK: Death Label
        let deathLabel = UILabel()
        deathLabel.text = "Death"
        deathLabel.textColor = UIColor(named: "red")
        deathLabel.setDemiboldFont(17)
        numberDeathLabel = UILabel()
        numberDeathLabel.text = "2,339"
        numberDeathLabel.textColor = UIColor(named: "red")
        numberDeathLabel.setBoldFont(28)
        
        let deathStackView = UIStackView()
        deathStackView.axis = .vertical
        deathStackView.spacing = 8
        deathStackView.alignment = .center
        deathStackView.addArrangedSubview(deathLabel)
        deathStackView.addArrangedSubview(numberDeathLabel)
        deathContainer.addSubview(deathStackView)
        deathStackView.activeAutoLayout()
        deathStackView.setToCenter(deathContainer)
        
        // MARK: Global Label
        let globalLabel = UILabel()
        globalLabel.text = "Global Case Update"
        globalLabel.setDemiboldFont(20)
        containerView.addSubview(globalLabel)

        globalLabel.activeAutoLayout()
        globalLabel.setLeadingAnchor(containerView.leadingAnchor, constant: 16)
        globalLabel.setTopAnchor(recoverContainer.bottomAnchor, constant: 24)
        globalLabel.setTopAnchor(deathContainer.bottomAnchor, constant: 24)
        globalLabel.setTrailingAnchor(containerView.trailingAnchor, constant: -16)

        // MARK: Global Container
        globalContainer = UIView()
        globalContainer.clipsToBounds = true
        globalContainer.layer.cornerRadius = 20
        globalContainer.backgroundColor = .white
        globalContainer.addShadow()
        containerView.addSubview(globalContainer)

        globalContainer.activeAutoLayout()
        globalContainer.setLeadingAnchor(containerView.leadingAnchor, constant: 16)
        globalContainer.setTrailingAnchor(containerView.trailingAnchor, constant: -16)
        globalContainer.setTopAnchor(globalLabel.bottomAnchor, constant: 16)
        globalContainer.heightAnchor.constraint(lessThanOrEqualTo: recoverContainer.heightAnchor, multiplier: 1).isActive = true
        globalContainer.setBottomAnchor(view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
        
        // MARK: Global Infected
        let globalInfected = UILabel()
        globalInfected.text = "Infected"
        globalInfected.textColor = UIColor(named: "yellow")
        globalInfected.setDemiboldFont(17)
        numberGlobalInfectedLabel = UILabel()
        numberGlobalInfectedLabel.text = "\(covids?.global.totalInfected ?? 0)"
        numberGlobalInfectedLabel.textColor = UIColor(named: "yellow")
        numberGlobalInfectedLabel.setBoldFont(22)
        let globalInfectedStackView = UIStackView()
        globalInfectedStackView.axis = .vertical
        globalInfectedStackView.spacing = 8
        globalInfectedStackView.alignment = .center
        globalInfectedStackView.addArrangedSubview(globalInfected)
        globalInfectedStackView.addArrangedSubview(numberGlobalInfectedLabel)

        // MARK: Global Recovered
        let globalRecovered = UILabel()
        globalRecovered.text = "Recovered"
        globalRecovered.textColor = UIColor(named: "green")
        globalRecovered.setDemiboldFont(17)
        numberGlobalRecoverLabel = UILabel()
        numberGlobalRecoverLabel.text = "\(covids?.global.totalRecovered ?? 0)"
        numberGlobalRecoverLabel.textColor = UIColor(named: "green")
        numberGlobalRecoverLabel.setBoldFont(22)
        let globalRecoveredStackView = UIStackView()
        globalRecoveredStackView.axis = .vertical
        globalRecoveredStackView.spacing = 8
        globalRecoveredStackView.alignment = .center
        globalRecoveredStackView.addArrangedSubview(globalRecovered)
        globalRecoveredStackView.addArrangedSubview(numberGlobalRecoverLabel)

        // MARK: Global Death
        let globalDeath = UILabel()
        globalDeath.text = "Death"
        globalDeath.textColor = UIColor(named: "red")
        globalDeath.setDemiboldFont(17)
        numberGlobalDeathLabel = UILabel()
        numberGlobalDeathLabel.text = "\(covids?.global.totalDeath ?? 0)"
        numberGlobalDeathLabel.textColor = UIColor(named: "red")
        numberGlobalDeathLabel.setBoldFont(22)
        let globalDeathStackView = UIStackView()
        globalDeathStackView.axis = .vertical
        globalDeathStackView.spacing = 8
        globalDeathStackView.alignment = .center
        globalDeathStackView.addArrangedSubview(globalDeath)
        globalDeathStackView.addArrangedSubview(numberGlobalDeathLabel)

        // MARK: Global StackView
        let globalStackView = UIStackView()
        globalStackView.axis = .horizontal
        globalStackView.spacing = 24
        globalStackView.addArrangedSubview(globalInfectedStackView)
        globalStackView.addArrangedSubview(globalRecoveredStackView)
        globalStackView.addArrangedSubview(globalDeathStackView)
        globalContainer.addSubview(globalStackView)

        globalStackView.activeAutoLayout()
        globalStackView.setToCenter(globalContainer)

    }
    
    private func setPickerView() {
        countriesPicker = UIPickerView()
        countriesPicker.dataSource = self
        countriesPicker.delegate = self
        countriesPicker.backgroundColor = .white
        countriesPicker.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height / 4 + 30)
        
        view.addSubview(countriesPicker)
        
        countriesPicker.activeAutoLayout()
        countriesPicker.setBottomAnchor(view.bottomAnchor, constant: 0)
        countriesPicker.setLeadingAnchor(view.leadingAnchor, constant: 0)
        countriesPicker.setTrailingAnchor(view.trailingAnchor, constant: 0)
        countriesPicker.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 4 + 30).isActive = true
        
    }
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (covids?.countries.count ?? 0)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return covids?.countries[row].country
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DispatchQueue.main.async {
            self.countryLabel.text = "\(self.covids?.countries[row].country ?? "")"
            self.numberNewCaseLabel.numberFormatter(self.covids?.countries[row].newConfirmed ?? 0)
            self.numberTotalCaseLabel.numberFormatter(self.covids?.countries[row].totalConfirmed ?? 0)
            self.numberRecoverLabel.numberFormatter(self.covids?.countries[row].totalRecovered ?? 0)
            self.numberDeathLabel.numberFormatter(self.covids?.countries[row].totalDeath ?? 0)
        }
        
    }
    
    @objc func moreCountry() {
        
        if isOnPicker {
            print("dismiss")
            UIView.animate(withDuration: 0.5) {
                self.countriesPicker.transform = CGAffineTransform(translationX: 0, y: (UIScreen.main.bounds.height / 4 + 30))
            }
        } else {
            print("show up")
            UIView.animate(withDuration: 0.5) {
                self.countriesPicker.transform = .identity
            }
        }
        
        self.isOnPicker.toggle()
    }

}

extension UIView {
    
    func addShadow() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 20
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 20
    }
    
    func activeAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setTopAnchor(_ topAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat) {
        self.topAnchor.constraint(equalTo: topAnchor, constant: constant).isActive = true
    }
    
    func setLeadingAnchor(_ leadingAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat) {
        self.leadingAnchor.constraint(equalTo: leadingAnchor, constant: constant).isActive = true
    }
    
    func setTrailingAnchor(_ leadingAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat) {
        self.trailingAnchor.constraint(equalTo: leadingAnchor, constant: constant).isActive = true
    }
    
    func setBottomAnchor(_ bottomAnchor: NSLayoutYAxisAnchor, constant: CGFloat) {
        self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: constant).isActive = true
    }
    
    func setToCenter(_ parentView: UIView) {
        self.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
    }
    
}

extension UILabel {
    
    func setDemiboldFont(_ size: CGFloat) {
        self.font = UIFont(name: "AvenirNext-Demibold", size: size)
    }
    
    func setBoldFont(_ size: CGFloat) {
        self.font = UIFont(name: "AvenirNext-Bold", size: size)
    }
    
    func numberFormatter(_ numberLabel: Int) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        self.text = formatter.string(from: NSNumber(value: Int(numberLabel)))
    }

}

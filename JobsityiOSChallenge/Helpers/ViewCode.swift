//
//  ViewCode.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 02/03/22.
//

import Foundation

protocol ViewCode {
    
    ///This function is to setup the view
    func setupView()
    
    ///This function is to setup the view hierarchy
    func setupHierarchy()
    
    ///This function is to setup the viewConstraints
    func setupConstraints()
    
    ///This function is to make any additional setup that you want
    func additionalSetup()
}

extension ViewCode {
    func setupView() {
        setupHierarchy()
        setupConstraints()
        additionalSetup()
    }
    
    func additionalSetup() {
        
    }
}

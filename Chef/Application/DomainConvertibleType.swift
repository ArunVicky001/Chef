//
//  DomainConvertible.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 12/01/22
//  Copyright (c) . All rights reserved.
//

import Foundation

protocol DomainConvertibleType {
    associatedtype DomainType
    
    func asDomain() -> DomainType
}

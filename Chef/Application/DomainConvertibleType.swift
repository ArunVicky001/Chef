//
//  DomainConvertible.swift
//  SuperTeacher
//
//  Created by Bhagyashree Myanamwar on 28/07/20.
//  Copyright © 2020 Toppr. All rights reserved.
//

import Foundation

protocol DomainConvertibleType {
    associatedtype DomainType
    
    func asDomain() -> DomainType
}

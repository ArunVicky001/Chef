//
//  ModuleHeaderViewModel.swift
//  SchoolOS
//
//  Created by Bhagyashree Myanamwar on 30/07/20.
//  Copyright © 2020 Toppr. All rights reserved.
//

import Foundation

class ModuleHeaderViewModel {
    
    let title: String
    let description: String
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    init(title: String, studentEntity: StudentProfileEntity) {
        self.title = title
        description = "Class \(studentEntity.klass), Div \(studentEntity.division)"
    }
    
    init(title: String, profile: ProfileEntity) {
        self.title = title
        switch profile {
        case .student(let studentProfile):
            description = "Class \(studentProfile.klass), Div \(studentProfile.division)"
        case .teacher(let teacherProfile):
            description = ""
        }
    }
}

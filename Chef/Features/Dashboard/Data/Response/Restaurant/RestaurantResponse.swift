//
//  RestaurantResponse.swift
//
//  Created by Vignesh Arunagiri on 02/06/22
//  Copyright (c) . All rights reserved.
//

import SwiftyJSON

struct RestaurantResponse: StructuredParser {
    
    let data: [DataResponse]

    init(from json: JSON) {
        data = json.arrayValue.compactMap(DataResponse.init)
    }
}

extension RestaurantResponse: DomainConvertibleType {
    func asDomain() -> [DataEntity] {
        return data.map{ $0.asDomain() }
    }
}



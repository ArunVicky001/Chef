//
//  MenuResponse.swift
//
//  Created by Vignesh Arunagiri on 04/06/22
//  Copyright (c) . All rights reserved.
//

import SwiftyJSON

struct MenuResponse: StructuredParser {
    
    let data: [MenuDataResponse]

    init(from json: JSON) {
        data = json.arrayValue.compactMap(MenuDataResponse.init)
    }
}

extension MenuResponse: DomainConvertibleType {
    func asDomain() -> [MenuDataEntity] {
        return data.map{ $0.asDomain() }
    }
}


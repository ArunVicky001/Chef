//
//  RestaurantResponse.swift
//
//  Created by Vignesh Arunagiri on 02/06/22
//  Copyright (c) . All rights reserved.
//

import SwiftyJSON

struct RestaurantResponse: StructuredParser {

	let data: [DataResponse]
	let successful: Bool
	let statusCode: Int

    init(from json: JSON) {
		data = json["data"].arrayValue.compactMap(DataResponse.init)
		successful = json["successful"].boolValue
		statusCode = json["statusCode"].intValue
    }
}

extension RestaurantResponse: DomainConvertibleType {
    func asDomain() -> RestaurantEntity {
        return RestaurantEntity(
            data: data.map{ $0.asDomain() },
			successful: successful,
			statusCode: statusCode)
    }
}

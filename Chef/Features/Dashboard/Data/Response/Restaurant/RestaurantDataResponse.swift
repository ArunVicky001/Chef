//
//  DataResponse.swift
//
//  Created by Vignesh Arunagiri on 02/06/22
//  Copyright (c) . All rights reserved.
//

import SwiftyJSON

struct RestaurantDataResponse: StructuredParser {

	let createdDate: String
	let updatedDate: String
	let chefId: Int
	let zipcode: Int
	let chefName: String
	let id: Int
	let type: String
	let name: String

    init(from json: JSON) {
		createdDate = json["createdDate"].stringValue
		updatedDate = json["updatedDate"].stringValue
		chefId = json["chefId"].intValue
		zipcode = json["zipcode"].intValue
		chefName = json["chefName"].stringValue
		id = json["id"].intValue
		type = json["type"].stringValue
		name = json["name"].stringValue
    }
}

extension RestaurantDataResponse: DomainConvertibleType {
    func asDomain() -> RestaurantDataEntity {
        return RestaurantDataEntity(
            createdDate: createdDate,
			updatedDate: updatedDate,
			chefId: chefId,
			zipcode: zipcode,
			chefName: chefName,
			id: id,
			type: type,
			name: name)
    }
}

//
//  DataResponse.swift
//
//  Created by Vignesh Arunagiri on 02/06/22
//  Copyright (c) . All rights reserved.
//

import SwiftyJSON

struct DataResponse: StructuredParser {

	let updatedDate: String
	let chefId: Int
	let type: String
	let name: String
	let zipcode: Int
	let id: Int
	let chefName: String
	let createdDate: String

    init(from json: JSON) {
		updatedDate = json["updatedDate"].stringValue
		chefId = json["chefId"].intValue
		type = json["type"].stringValue
		name = json["name"].stringValue
		zipcode = json["zipcode"].intValue
		id = json["id"].intValue
		chefName = json["chefName"].stringValue
		createdDate = json["createdDate"].stringValue
    }
}

extension DataResponse: DomainConvertibleType {
    func asDomain() -> DataEntity {
        return DataEntity(
            updatedDate: updatedDate,
			chefId: chefId,
			type: type,
			name: name,
			zipcode: zipcode,
			id: id,
			chefName: chefName,
			createdDate: createdDate)
    }
}


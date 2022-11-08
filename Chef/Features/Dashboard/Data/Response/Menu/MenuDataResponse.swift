//
//  DataResponse.swift
//
//  Created by Vignesh Arunagiri on 04/06/22
//  Copyright (c) . All rights reserved.
//

import SwiftyJSON

struct MenuDataResponse: StructuredParser {

	let title: String?
	let summary: String?
	let type: String?
	let updatedDate: String?
	let restaurantId: Int?
	let userId: String?
	let id: Int?
	let createdDate: String?

    init(from json: JSON) {
		title = json["title"].string
		summary = json["summary"].string
		type = json["type"].string
		updatedDate = json["updatedDate"].string
		restaurantId = json["restaurantId"].int
		userId = json["userId"].string
		id = json["id"].int
		createdDate = json["createdDate"].string
    }
}

extension MenuDataResponse: DomainConvertibleType {
    func asDomain() -> MenuDataEntity {
        return MenuDataEntity(
            title: title,
			summary: summary,
			type: type,
			updatedDate: updatedDate,
			restaurantId: restaurantId,
			userId: userId,
			id: id,
			createdDate: createdDate)
    }
}

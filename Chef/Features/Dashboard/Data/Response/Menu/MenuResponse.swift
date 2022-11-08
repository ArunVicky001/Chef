//
//  MenuResponse.swift
//
//  Created by Vignesh Arunagiri on 04/06/22
//  Copyright (c) . All rights reserved.
//

import SwiftyJSON

struct MenuResponse: StructuredParser {

	let statusCode: Int?
	let data: [DataResponse]?
	let successful: Bool?

    init(from json: JSON) {
		statusCode = json["statusCode"].int
		data = json["data"].arrayValue.compactMap(DataResponse.init)
		successful = json["successful"].bool
    }
}

extension MenuResponse: DomainConvertibleType {
    func asDomain() -> MenuEntity {
        return MenuEntity(
            statusCode: statusCode,
			data: data.map{ $0.asDomain() },
			successful: successful)
    }
}

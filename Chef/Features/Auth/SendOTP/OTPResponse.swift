//
//  OTPResponse.swift
//
//  Created by Vignesh Arunagiri on 21/05/22
//  Copyright (c) . All rights reserved.
//

import SwiftyJSON

struct OTPResponse: StructuredParser {

	let statusCode: Int
	let message: String
	let status: String
	let data: OTPDataResponse

    init(from json: JSON) {
		statusCode = json["status_code"].intValue
		message = json["message"].stringValue
		status = json["status"].stringValue
		data = DataResponse(json: json["data"])
    }
}

extension OTPResponse: DomainConvertibleType {
    func asDomain() -> OTPEntity {
        return OTPEntity(
            statusCode: statusCode,
			message: message,
			status: status,
			data: data.asDomain())
    }
}

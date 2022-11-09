//
//  ValidateOTPResponse.swift
//
//  Created by Vignesh Arunagiri on 27/05/22
//  Copyright (c) . All rights reserved.
//

import SwiftyJSON

struct ValidateOTPResponse: StructuredParser {

	let statusCode: Int
	let message: String
	let data: ValidateOTPDataResponse
	let status: String

    init(from json: JSON) {
		statusCode = json["status_code"].intValue
		message = json["message"].stringValue
		data = ValidateOTPDataResponse(from: json["data"])
		status = json["status"].stringValue
    }
}

extension ValidateOTPResponse: DomainConvertibleType {
    func asDomain() -> ValidateOTPEntity {
        return ValidateOTPEntity(
            statusCode: statusCode,
			message: message,
			data: data.asDomain(),
			status: status)
    }
}

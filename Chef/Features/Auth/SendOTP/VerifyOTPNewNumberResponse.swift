//
//  VerifyOTPNewNumberResponseResponse.swift
//
//  Created by Vignesh Arunagiri on 12/01/22
//  Copyright (c) . All rights reserved.
//

import TopprUtilitiesiOS
import SwiftyJSON

struct VerifyOTPNewNumberResponse: StructuredParser {

	let message: String
	let data: VerifyOTPNewNumberDataResponse

    init(from json: JSON) {
		message = json["message"].stringValue
		data = VerifyOTPNewNumberDataResponse(json: json["data"])
    }
}

extension VerifyOTPNewNumberResponse: DomainConvertibleType {
    func asDomain() -> VerifyOTPNewNumberResponseEntity {
        return VerifyOTPNewNumberResponseEntity(
            message: message,
			data: data.asDomain())
    }
}

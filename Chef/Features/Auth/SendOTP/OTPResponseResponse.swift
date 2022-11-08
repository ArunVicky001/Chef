//
//  OTPResponseResponse.swift
//
//  Created by Vignesh Arunagiri on 03/05/22
//  Copyright (c) . All rights reserved.
//

import TopprUtilitiesiOS
import SwiftyJSON

struct OTPResponseResponse: StructuredParser {

	let mobileNumber: String?
	let otp: String?
	let deviceId: String?
	let text: String?

    init(from json: JSON) {
		mobileNumber = json["mobileNumber"].string
		otp = json["otp"].string
		deviceId = json["deviceId"].string
		text = json["text"].string
    }
}

extension OTPResponseResponse: DomainConvertibleType {
    func asDomain() -> OTPResponseEntity {
        return OTPResponseEntity(
            mobileNumber: mobileNumber,
			otp: otp,
			deviceId: deviceId,
			text: text)
    }
}

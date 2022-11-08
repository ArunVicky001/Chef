//
//  OTPResponseEntity.swift
//
//  Created by Vignesh Arunagiri on 03/05/22
//  Copyright (c) . All rights reserved.
//

import TopprUtilitiesiOS
import SwiftyJSON

struct OTPResponseEntity: StructuredParser {

	let mobileNumber: String?
	let otp: String?
	let deviceId: String?
	let text: String?

}

//
//  Amax.swift
//
//  Created by Rico Maglayon on 08/12/2016.
//

import Foundation

@objc(Amax) class Amax : CDVPlugin {
    var amaxAppId: String?
    var amaxAppSecret: String?
    var amaxAddress: String?
    var amaxRewardsToken: String?
    var amaxPromo: String?

    @objc(setAppId:) func setAppId(command: CDVInvokedUrlCommand) -> Amax {
        let argument = command.arguments[0] as? String ?? ""
        self.amaxAppId = argument

        return self
    }

    @objc(setAppSecret:) func setAppSecret(command: CDVInvokedUrlCommand) -> Amax {
        let argument = command.arguments[0] as? String ?? ""
        self.amaxAppSecret = argument

        return self
    }

    @objc(setAddress:) func setAddress(command: CDVInvokedUrlCommand) -> Amax {
        let argument = command.arguments[0] as? String ?? ""
        self.amaxAddress = argument

        return self
    }

    @objc(setRewardsToken:) func setRewardsToken(command: CDVInvokedUrlCommand) -> Amax {
        let argument = command.arguments[0] as? String ?? ""
        self.amaxRewardsToken = argument

        return self
    }

    @objc(setPromo:) func setPromo(command: CDVInvokedUrlCommand) -> Amax {
        let argument = command.arguments[0] as? String ?? ""
        self.amaxPromo = argument

        return self
    }

    @objc(sendRewardRequest:) func sendRewardRequest(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )

        // set the url
        let sendRewardRequestURL = "https://devapi.globelabs.com.ph/rewards/v1/transactions/send"

        // prepare the payload
        let data: [String : [String: Any]] = [
            "outboundRewardRequest" : [
                "app_id"        : self.amaxAppId!,
                "app_secret"    : self.amaxAppSecret!,
                "rewards_token" : self.amaxRewardsToken!,
                "address"       : self.amaxAddress!,
                "promo"         : self.amaxPromo!
            ]
        ]

        // set the header/s
        var headers = Dictionary<String, String>()
        headers["Content-Type"] = "application/json; charset=utf-8"

        do {
            // convert it!
            let jsonData = try JSONSerialization.data(
                withJSONObject: data,
                options: JSONSerialization.WritingOptions.prettyPrinted
            )

            // it is now in json so we need it to be a string so we can send it
            if let jsonPayload = String(data: jsonData, encoding: String.Encoding.utf8) {
                HTTPRequest(url: sendRewardRequestURL, headers: headers)
                    .post(
                        parameters: jsonPayload,
                        success: { data, _ in
                            DispatchQueue.global(qos: .utility).async {
                                DispatchQueue.main.async {
                                    pluginResult = CDVPluginResult(
                                        status: CDVCommandStatus_OK,
                                        messageAs: String(data: data, encoding: .utf8)
                                    )

                                    self.commandDelegate!.send(
                                        pluginResult,
                                        callbackId: command.callbackId
                                    )
                                }
                            }
                    }, failure: { error, data in
                        pluginResult = CDVPluginResult(
                            status: CDVCommandStatus_ERROR,
                            messageAs: String(data: data, encoding: .utf8)
                        )

                        self.commandDelegate!.send(
                            pluginResult,
                            callbackId: command.callbackId
                        )
                    })
            }
        } catch let error as NSError {
            // oops, error in converting it to JSON
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs: error.localizedDescription
            )

            self.commandDelegate!.send(
                pluginResult,
                callbackId: command.callbackId
            )
        }
    }
}

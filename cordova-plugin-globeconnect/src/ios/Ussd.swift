//
//  Ussd.swift
//
//  Created by Rico Maglayon on 08/12/2016.
//

import Foundation

@objc(Ussd) class Ussd : CDVPlugin {
    var ussdAccessToken: String?
    var ussdSenderAddress: String?
    var ussdUssdMessage: String?
    var ussdAddress: String?
    var ussdFlash: Bool?
    var ussdSessionId: String?

    @objc(setAccessToken:) func setAccessToken(command: CDVInvokedUrlCommand) -> Ussd {
        let argument = command.arguments[0] as? String ?? ""
        self.ussdAccessToken = argument

        return self
    }

    @objc(setSenderAddress:) func setSenderAddress(command: CDVInvokedUrlCommand) -> Ussd {
        let argument = command.arguments[0] as? String ?? ""
        self.ussdSenderAddress = argument

        return self
    }

    @objc(setUssdMessage:) func setUssdMessage(command: CDVInvokedUrlCommand) -> Ussd {
        let argument = command.arguments[0] as? String ?? ""
        self.ussdUssdMessage = argument

        return self
    }

    @objc(setAddress:) func setAddress(command: CDVInvokedUrlCommand) -> Ussd {
        let argument = command.arguments[0] as? String ?? ""
        self.ussdAddress = argument

        return self
    }

    @objc(setFlash:) func setFlash(command: CDVInvokedUrlCommand) -> Ussd {
        let argument = command.arguments[0] as? Bool ?? false
        self.ussdFlash = argument

        return self
    }

    @objc(setSessionId:) func setSessionId(command: CDVInvokedUrlCommand) -> Ussd {
        let argument = command.arguments[0] as? String ?? ""
        self.ussdSessionId = argument

        return self
    }

    @objc(sendUssdRequest:) func sendUssdRequest(command: CDVInvokedUrlCommand) -> Ussd {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )

        // set the request url
        var sendUssdRequestURL = "https://devapi.globelabs.com.ph/ussd/v1/outbound/"
        sendUssdRequestURL += self.ussdSenderAddress!+"/send/requests?access_token="+self.ussdAccessToken!

        // prepare the payload
        let data: [String : [String: Any]] = [
            "outboundUSSDMessageRequest" : [
                "outboundUSSDMessage" : [
                    "message": self.ussdUssdMessage!
                ],
                "address"       : self.ussdAddress!,
                "senderAddress" : self.ussdSenderAddress!,
                "flash"         : self.ussdFlash!
            ]
        ]

        // set the header/s
        var headers = Dictionary<String, String>()
        headers["Content-Type"] = "application/json; charset=utf-8"

        // we need to convert first the payload to JSON
        do {
            // convert it!
            let jsonData = try JSONSerialization.data(
                withJSONObject: data,
                options: JSONSerialization.WritingOptions.prettyPrinted
            )

            // it is now in json so we need it to be a string so we can send it
            if let jsonPayload = String(data: jsonData, encoding: String.Encoding.utf8) {
                HTTPRequest(url: sendUssdRequestURL, headers: headers)
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

        return self
    }

    @objc(replyUssdRequest:) func replyUssdRequest(command: CDVInvokedUrlCommand) -> Ussd {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )

        // set the request url
        var replyUssdRequestURL = "https://devapi.globelabs.com.ph/ussd/v1/outbound/"
        replyUssdRequestURL += self.ussdSenderAddress!+"/reply/requests?access_token="+self.ussdAccessToken!

        // prepare the payload
        let data: [String : [String: Any]] = [
            "outboundUSSDMessageRequest" : [
                "outboundUSSDMessage" : [
                    "message": self.ussdUssdMessage!
                ],
                "address"       : self.ussdAddress!,
                "senderAddress" : self.ussdSenderAddress!,
                "sessionID"     : self.ussdSessionId!,
                "flash"         : self.ussdFlash!
            ]
        ]

        // set the header/s
        var headers = Dictionary<String, String>()
        headers["Content-Type"] = "application/json; charset=utf-8"

        // we need to convert first the payload to JSON
        do {
            // convert it!
            let jsonData = try JSONSerialization.data(
                withJSONObject: data,
                options: JSONSerialization.WritingOptions.prettyPrinted
            )

            // it is now in json so we need it to be a string so we can send it
            if let jsonPayload = String(data: jsonData, encoding: String.Encoding.utf8) {
                HTTPRequest(url: replyUssdRequestURL, headers: headers)
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

        return self
    }
}

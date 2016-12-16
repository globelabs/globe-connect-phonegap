//
//  Sms.swift
//
//  Created by Rico Maglayon on 08/12/2016.
//

import Foundation

@objc(Sms) class Sms : CDVPlugin {
    var smsSenderAddress: String?
    var smsAccessToken: String?
    var smsClientCorrelator: String?
    var smsReceiverAddress: String?
    var smsMessage: String?

    @objc(setSenderAddress:) func setSenderAddress(command: CDVInvokedUrlCommand) -> Sms {
        let argument = command.arguments[0] as? String ?? ""
        self.smsSenderAddress = argument

        return self
    }

    @objc(setAccessToken:) func setAccessToken(command: CDVInvokedUrlCommand) -> Sms {
        let argument = command.arguments[0] as? String ?? ""
        self.smsAccessToken = argument

        return self
    }

    @objc(setClientCorrelator:) func setClientCorrelator(command: CDVInvokedUrlCommand) -> Sms {
        let argument = command.arguments[0] as? String ?? ""
        self.smsClientCorrelator = argument

        return self
    }

    @objc(setReceiverAddress:) func setReceiverAddress(command: CDVInvokedUrlCommand) -> Sms {
        let argument = command.arguments[0] as? String ?? ""
        self.smsReceiverAddress = argument

        return self
    }

    @objc(setMessage:) func setMessage(command: CDVInvokedUrlCommand) -> Sms {
        let argument = command.arguments[0] as? String ?? ""
        self.smsMessage = argument

        return self
    }

    @objc(sendMessage:) func sendMessage(command: CDVInvokedUrlCommand) -> Sms {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )

        // set the url
        let sendMessageUrl = "https://devapi.globelabs.com.ph/smsmessaging/v1/outbound/"+self.smsSenderAddress!+"/requests?access_token="+self.smsAccessToken!

        // set the header/s
        var headers = Dictionary<String, String>()
        headers["Content-Type"] = "application/json; charset=utf-8"

        // fix the address
        let address = "tel:" + self.smsReceiverAddress!

        // fix the sender address
        let sender = "tel:" + self.smsSenderAddress!

        // prepare the payload
        let data: [String : [String: Any]] = [
            "outboundSMSMessageRequest" : [
                "senderAddress"           : sender,
                "address"                 : [address],
                "outboundSMSTextMessage"  : [
                    "message" : self.smsMessage!
                ]
            ]
        ]

        // we need to convert first the payload to JSON
        do {
            // convert it!
            let jsonData = try JSONSerialization.data(
                withJSONObject: data,
                options: JSONSerialization.WritingOptions.prettyPrinted
            )

            // it is now in json so we need it to be a string so we can send it
            if let jsonPayload = String(data: jsonData, encoding: String.Encoding.utf8) {
                HTTPRequest(url: sendMessageUrl, headers: headers)
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

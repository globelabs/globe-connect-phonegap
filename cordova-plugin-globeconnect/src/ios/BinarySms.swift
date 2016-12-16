//
//  BinarySms.swift
//  Sample
//
//  Created by Rico Maglayon on 08/12/2016.
//
//

import Foundation

@objc(BinarySms) class BinarySms : CDVPlugin {
    var binarySmsSenderAddress: String?
    var binarySmsAccessToken: String?
    var binarySmsUserDataHeader: String?
    var binarySmsDataCodingScheme : Int?
    var binarySmsReceiverAddress : String?
    var binarySmsBinaryMessage : String?

    @objc(setSenderAddress:) func setSenderAddress(command: CDVInvokedUrlCommand) -> BinarySms {
        let argument = command.arguments[0] as? String ?? ""
        self.binarySmsSenderAddress = argument

        return self
    }

    @objc(setAccessToken:) func setAccessToken(command: CDVInvokedUrlCommand) -> BinarySms {
        let argument = command.arguments[0] as? String ?? ""
        self.binarySmsAccessToken = argument

        return self
    }

    @objc(setUserDataHeader:) func setUserDataHeader(command: CDVInvokedUrlCommand) -> BinarySms {
        let argument = command.arguments[0] as? String ?? ""
        self.binarySmsUserDataHeader = argument

        return self
    }

    @objc(setDataCodingScheme:) func setDataCodingScheme(command: CDVInvokedUrlCommand) -> BinarySms {
        let argument = command.arguments[0] as? Int ?? 1
        self.binarySmsDataCodingScheme = argument

        return self
    }

    @objc(setReceiverAddress:) func setReceiverAddress(command: CDVInvokedUrlCommand) -> BinarySms {
        let argument = command.arguments[0] as? String ?? ""
        self.binarySmsReceiverAddress = argument

        return self
    }

    @objc(setBinaryMessage:) func setBinaryMessage(command: CDVInvokedUrlCommand) -> BinarySms {
        let argument = command.arguments[0] as? String ?? ""
        self.binarySmsBinaryMessage = argument

        return self
    }

    @objc(sendBinaryMessage:) func sendBinaryMessage(command: CDVInvokedUrlCommand) -> Void {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )

        // set the url
        let binarySmsURL = "https://devapi.globelabs.com.ph/binarymessaging/v1/outbound/"+self.binarySmsSenderAddress!+"/requests?access_token="+self.binarySmsAccessToken!

        // set the header/s
        var headers = Dictionary<String, String>()
        headers["Content-Type"] = "application/json; charset=utf-8"

        // prepare the payload
        let data: [String : [String: Any]] = [
            "outboundBinaryMessageRequest" : [
                "userDataHeader"        : self.binarySmsUserDataHeader!,
                "dataCodingScheme"      : self.binarySmsDataCodingScheme!,
                "address"               : self.binarySmsReceiverAddress!,
                "senderAddress"         : self.binarySmsSenderAddress!,
                "access_token"          : self.binarySmsAccessToken!,
                "outboundBinaryMessage" : [
                    "message" : self.binarySmsBinaryMessage!
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
                HTTPRequest(url: binarySmsURL, headers: headers)
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

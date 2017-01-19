//
//  Authentication.swift
//
//  Created by Rico Maglayon on 08/12/2016.
//

import Foundation

@objc(Authentication) class Authentication : CDVPlugin {
    var authAppId: String?
    var authAppSecret: String?
    var authCode: String?

    @objc(setAppId:) func setAppId(command: CDVInvokedUrlCommand) -> Authentication {
        let argument = command.arguments[0] as? String ?? ""
        self.authAppId = argument

        return self
    }

    @objc(setAppSecret:) func setAppSecret(command: CDVInvokedUrlCommand) -> Authentication {
        let argument = command.arguments[0] as? String ?? ""
        self.authAppSecret = argument

        return self
    }

    @objc(setCode:) func setCode(command: CDVInvokedUrlCommand) -> Authentication {
        let argument = command.arguments[0] as? String ?? ""
        self.authCode = argument

        return self
    }

    @objc(getAccessToken:) func getAccessToken(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )

        // set the url
        let accessTokenURL = "https://developer.globelabs.com.ph/oauth/access_token"

        // set the header/s
        var headers = Dictionary<String, String>()
        headers["Content-Type"] = "application/x-www-form-urlencoded; charset=utf-8"

        let code = command.arguments[0] as? String ?? ""

        if !code.isEmpty {
            self.authCode = code
        }

        // set the payload
        let payload: [String : String] = [
            "app_id": self.authAppId!,
            "app_secret": self.authAppSecret!,
            "code":self.authCode!
        ]

        // build the payload
        var body: String = ""
        for (key, value) in payload {
            body = body.appending(key)
            body = body.appending("=")
            body = body.appending(value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
            body = body.appending("&")
        }

        print(accessTokenURL)
        print(payload)

        // perform http request
        HTTPRequest(url: accessTokenURL, headers: headers)
            .post(
                parameters: body,
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

    @objc(getDialogUrl:) func getDialogUrl(command: CDVInvokedUrlCommand) {
        let dialogUrl = "https://developer.globelabs.com.ph/dialog/oauth?app_id=" + self.authAppId!

        let pluginResult = CDVPluginResult(
            status: CDVCommandStatus_OK,
            messageAs: dialogUrl
        )

        self.commandDelegate!.send(
            pluginResult,
            callbackId: command.callbackId
        )
    }
}

/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
var app = {
    // Application Constructor
    initialize: function() {
        document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
    },

    // deviceready Event Handler
    //
    // Bind any cordova events here. Common events are:
    // 'pause', 'resume', etc.
    onDeviceReady: function() {
        this.receivedEvent('deviceready');

        this.testAuthFlow();
        // this.testAuthentication();
        // this.testAmax();
        // this.testBinarySms();
        // this.testLocation();
        // this.testPayment();
        // this.testSms();
        // this.testSubscriber();
        // this.testUssd();
    },

    testAuthFlow : function() {
        var auth = globeconnect.Authentication();

        auth.startAuthActivity(
        '5ozgSgeRyeHzacXo55TR65HnqoAESbAz',
        '3dbcd598f268268e13550c87134f8de0ec4ac1100cf0a68a2936d07fc9e2459e',
        function() {
            console.log(arguments);
        },
        function() {
            console.log(arguments);
        });
    },

    testAuthentication : function() {
        var auth = globeconnect.Authentication(
            '5ozgSgeRyeHzacXo55TR65HnqoAESbAz',
            '3dbcd598f268268e13550c87134f8de0ec4ac1100cf0a68a2936d07fc9e2459e');

        auth.getDialogUrl(function() {
            console.log(arguments);
        }, function() {
            console.log(arguments);
        });

        var code = 'qbFx7o5afb6b4XtMyd6afL9aM6fAzjpEte44entr5A6KSdzjR6ILM74qSqjAepsx9gzgsdkqkRIaeRapu9A4zpu5q6RrS7kpzEsr6kKzHp6AR8CnejpRsEzRKpu4RikRyKaiRaxuGzj4osX8Ap6CbpkEGHaopyrsor6kXS6G4eBueKRRnu8oq9KI96gBks54AAnsMk7LpSb5j8gIn4A4zSKa4RptLXjyAtLrad7f9ndMEfnkboXt8XoBafRpk9oF';

        auth.getAccessToken(code, function() {
            console.log(arguments);
        }, function() {
            console.log(arguments);
        });
    },

    testAmax : function() {
        var amax = globeconnect.Amax(
            '5ozgSgeRyeHzacXo55TR65HnqoAESbAz',
            '3dbcd598f268268e13550c87134f8de0ec4ac1100cf0a68a2936d07fc9e2459e'
        );

        amax
            .setAddress('9065272450')
            .setRewardsToken('w7hYKxrE7ooHqXNBQkP9lg')
            .setPromo('FREE10MB');

        amax.sendRewardRequest(function() {
            console.log(arguments);
        }, function() {
            console.log(arguments);
        });
    },

    testBinarySms : function() {
        var binary = globeconnect.BinarySms(
            '21584130',
            'kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA'
        );

        binary
            .setUserDataHeader('06050423F423F4')
            .setDataCodingScheme(1)
            .setReceiverAddress('9271223448')
            .setBinaryMessage('02056A0045C60C037777772E6465762E6D6F62692F69735F66756E2E68746D6C0');

        binary.sendBinaryMessage(function() {
            console.log(arguments);
        }, function() {
            console.log(arguments);
        });
    },

    testLocation : function() {
        var location = globeconnect.Location('JO3SpcC-AFiC461wgOxUPDmsOTc5YiMayoK1GnQcduc');

        location
            .setAddress('09065272450')
            .setRequestedAccuracy(10);

        location.getLocation(function() {
            console.log(arguments);
        }, function() {
            console.log(arguments);
        });
    },

    testPayment : function() {
        var payment = globeconnect.Payment('JO3SpcC-AFiC461wgOxUPDmsOTc5YiMayoK1GnQcduc');

        payment
            .setAppId('5ozgSgeRyeHzacXo55TR65HnqoAESbAz')
            .setAppSecret('3dbcd598f268268e13550c87134f8de0ec4ac1100cf0a68a2936d07fc9e2459e')
            .setAmount(0.00)
            .setDescription('My Description')
            .setEndUserId('9065272450')
            .setReferenceCode('41301000301')
            .setTransactionOperationStatus('Charged')
            .sendPaymentRequest(function() {
                console.log(arguments);
            }, function() {
                console.log(arguments);
            })
            .getLastReferenceCode(function() {
                console.log(arguments);
            }, function() {
                console.log(arguments);
            });
    },

    testSms : function() {
        var sms = globeconnect.Sms(
            '21584130',
            'JO3SpcC-AFiC461wgOxUPDmsOTc5YiMayoK1GnQcduc'
        );

        sms
            .setClientCorrelator('12345')
            .setReceiverAddress('+639065272450')
            .setMessage('Hello World');

        sms.sendMessage(function() {
            console.log(arguments);
        }, function() {
            console.log(arguments);
        });
    },

    testSubscriber : function() {
        var subscriber = globeconnect.Subscriber('JO3SpcC-AFiC461wgOxUPDmsOTc5YiMayoK1GnQcduc');

        subscriber
            .setAddress('639065272450')
            .getSubscriberBalance(function() {
                console.log(arguments);
            }, function() {
                console.log(arguments);
            })
            .getSubscriberReloadAmount(function() {
                console.log(arguments);
            }, function() {
                console.log(arguments);
            });
    },

    testUssd : function() {
        var ussd = globeconnect.Ussd('JO3SpcC-AFiC461wgOxUPDmsOTc5YiMayoK1GnQcduc');

        ussd
            .setSenderAddress('21584130')
            .setUssdMessage('Simple USSD Message\n1: Hello \n2: Hello')
            .setAddress('9065272450')
            .setFlash(false)
            .sendUssdRequest(function() {
                console.log(arguments);
            }, function() {
                console.log(arguments);
            });

        ussd
            .setSessionId('12345')
            .setAddress('9065272450')
            .setSenderAddress('21584130')
            .setUssdMessage('Simple USSD Message\n1: Foo\n2: Foo')
            .setFlash(false)
            .replyUssdRequest(function() {
                console.log(arguments);
            }, function() {
                console.log(arguments);
            });
    },

    // Update DOM on a Received Event
    receivedEvent: function(id) {
        var parentElement = document.getElementById(id);
        var listeningElement = parentElement.querySelector('.listening');
        var receivedElement = parentElement.querySelector('.received');

        listeningElement.setAttribute('style', 'display:none;');
        receivedElement.setAttribute('style', 'display:block;');

        console.log('Received Event: ' + id);
    }
};

app.initialize();

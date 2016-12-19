# Globe Connect for Phonegap

## Introduction
Globe Connect for Phonegap platform provides an implementation of Globe APIs e.g Authentication, Amax,
Sms etc. that is easy to use and can be integrated in your existing Phonegap application. Below shows
some samples on how to use the API depending on the functionality that you need to integrate in your
application.

## Basic Usage

###### Figure 1. Authentication

```js
var auth = globeconnect.Authentication(
    '[app_id]',
    '[app_secret]');

auth.getDialogUrl(function() {
    console.log(arguments);
}, function() {
    console.log(arguments);
});

var code = '[code]';

auth.getAccessToken(code, function() {
    console.log(arguments);
}, function() {
    console.log(arguments);
});
```

###### Figure 2. Amax

```js
var amax = globeconnect.Amax(
    '[app_id]',
    '[app_secret]'
);

amax
    .setAddress('[+63 subscriber_number]')
    .setRewardsToken('[rewards_token]')
    .setPromo('[promo]');

amax.sendRewardRequest(function() {
    console.log(arguments);
}, function() {
    console.log(arguments);
});
```

###### Figure 3. Binary SMS

```js
var binary = globeconnect.BinarySms(
    '[short_code]',
    '[access_token]'
);

binary
    .setUserDataHeader('[data_header]')
    .setDataCodingScheme([scheme])
    .setReceiverAddress('[+63 subscriber_number]')
    .setBinaryMessage('[message]');

binary.sendBinaryMessage(function() {
    console.log(arguments);
}, function() {
    console.log(arguments);
});
```

###### Figure 4. Location

```js
var location = globeconnect.Location('[access_token]');

location
    .setAddress('[+63 subscriber_number]')
    .setRequestedAccuracy(10);

location.getLocation(function() {
    console.log(arguments);
}, function() {
    console.log(arguments);
});
```

###### Figure 5. Payment (Send Payment Request)

```js
var payment = globeconnect.Payment('[access_token]');

payment
    .setAppId('[app_id]')
    .setAppSecret('[app_secret]')
    .setAmount([amount])
    .setDescription('[description]')
    .setEndUserId('[+63 subscriber_number]')
    .setReferenceCode('[reference_code]')
    .setTransactionOperationStatus('[status]')
    .sendPaymentRequest(function() {
        console.log(arguments);
    }, function() {
        console.log(arguments);
    });
```

###### Figure 6. Payment (Get Last Reference ID)

```js
var payment = globeconnect.Payment('[access_token]');

payment
    .setAppId('[app_id]')
    .setAppSecret('[app_secret]')
    .getLastReferenceCode(function() {
        console.log(arguments);
    }, function() {
        console.log(arguments);
    });
```

###### Figure 7. Sms

```js
var sms = globeconnect.Sms(
    '[short_code]',
    '[access_token]'
);

sms
    .setClientCorrelator('[client_correlator]')
    .setReceiverAddress('[+63 subscriber_number]')
    .setMessage('[message]');

sms.sendMessage(function() {
    console.log(arguments);
}, function() {
    console.log(arguments);
});
```

###### Figure 8. Subscriber (Get Balance)

```java
var subscriber = globeconnect.Subscriber('[access_token]');

subscriber
    .setAddress('[+63 subscriber_number]')
    .getSubscriberBalance(function() {
        console.log(arguments);
    }, function() {
        console.log(arguments);
    });
```

###### Figure 9. Subscriber (Get Reload Amount)

```js
var subscriber = globeconnect.Subscriber('[access_token]');

subscriber
    .setAddress('[+63 subscriber_number]')
    .getSubscriberReloadAmount(function() {
        console.log(arguments);
    }, function() {
        console.log(arguments);
    });
```

###### Figure 10. USSD (Send)

```js
var ussd = globeconnect.Ussd('[access_token]');

ussd
    .setSenderAddress('[short_code]')
    .setUssdMessage('[message]')
    .setAddress('[+63 subscriber_number]')
    .setFlash([flash])
    .sendUssdRequest(function() {
        console.log(arguments);
    }, function() {
        console.log(arguments);
    });
```

###### Figure 11. USSD (Reply)

```js
var ussd = globeconnect.Ussd('[access_token]');

ussd
    .setSessionId('[session_id]')
    .setAddress('[+63 subscriber_number]')
    .setSenderAddress('[short_code]')
    .setUssdMessage('[message]')
    .setFlash([flash])
    .replyUssdRequest(function() {
        console.log(arguments);
    }, function() {
        console.log(arguments);
    });
```

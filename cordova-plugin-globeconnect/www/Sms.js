var exec = require('cordova/exec');

// Sms
var Sms = function(senderAddress, accessToken) {
    // short hand initialization
    if(!(this instanceof Sms)) {
        return new Sms(senderAddress, accessToken);
    }

    // class name
    this.class = 'Sms';

    // sender address set?
    if(senderAddress) {
        exec(null, null, this.class, 'setSenderAddress', [senderAddress]);
    }

    // access token set?
    if(accessToken) {
        exec(null, null, this.class, 'setAccessToken', [accessToken]);
    }

    /**
     * Set sender address.
     *
     * @param  string
     * @return this
     */
    this.setSenderAddress = function(senderAddress) {
        exec(null, null, this.class, 'setSenderAddress', [senderAddress]);

        return this;
    };

    /**
     * Set access token.
     *
     * @param  string
     * @return this
     */
    this.setAccessToken = function(accessToken) {
        exec(null, null, this.class, 'setAccessToken', [accessToken]);

        return this;
    };

    /**
     * Set client correlator.
     *
     * @param  string
     * @return this
     */
    this.setClientCorrelator = function(clientCorrelator) {
        exec(null, null, this.class, 'setClientCorrelator', [clientCorrelator]);

        return this;
    };

    /**
     * Set receiver address.
     *
     * @param  string
     * @return this
     */
    this.setReceiverAddress = function(receiverAddress) {
        exec(null, null, this.class, 'setReceiverAddress', [receiverAddress]);

        return this;
    };

    /**
     * Set message.
     *
     * @param  string
     * @return this
     */
    this.setMessage = function(message) {
        exec(null, null, this.class, 'setMessage', [message]);

        return this;
    };

    /**
     * Send message.
     *
     * @param  function
     * @param  function
     * @return this
     */
    this.sendMessage = function(successCallback, errorCallback) {
        var callback = function(data) {
            try {
                data = JSON.parse(data);
            } catch(e) {};

            successCallback.call(this, data);
        };

        exec(callback, errorCallback, this.class, 'sendMessage', []);

        return this;
    };
};

module.exports = Sms;

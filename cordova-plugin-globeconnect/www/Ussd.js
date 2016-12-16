var exec = require('cordova/exec');

// Ussd
var Ussd = function(accessToken) {
    // short hand initialization
    if(!(this instanceof Ussd)) {
        return new Ussd(accessToken);
    }

    // class name
    this.class = 'Ussd';

    // access token set?
    if(accessToken) {
        exec(null, null, this.class, 'setAccessToken', [accessToken]);
    }

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
     * Set ussd message.
     *
     * @param  string
     * @return this
     */
    this.setUssdMessage = function(ussdMessage) {
        exec(null, null, this.class, 'setUssdMessage', [ussdMessage]);

        return this;
    };

    /**
     * Set address.
     *
     * @param  string
     * @return this
     */
    this.setAddress = function(address) {
        exec(null, null, this.class, 'setAddress', [address]);

        return this;
    };

    /**
     * Set flash.
     *
     * @param  bool
     * @return this
     */
    this.setFlash = function(flash) {
        exec(null, null, this.class, 'setFlash', [flash]);

        return this;
    };

    /**
     * Set session id.
     *
     * @param  string
     * @return this
     */
    this.setSessionId = function(sessionId) {
        exec(null, null, this.class, 'setSessionId', [sessionId]);

        return this;
    };

    /**
     * Send ussd request.
     *
     * @param  function
     * @param  function
     * @return this
     */
    this.sendUssdRequest = function(successCallback, errorCallback) {
        var callback = function(data) {
            try {
                data = JSON.parse(data);
            } catch(e) {};

            successCallback.call(this, data);
        };

        exec(callback, errorCallback, this.class, 'sendUssdRequest', []);

        return this;
    };

    /**
     * Reply ussd request.
     *
     * @param  function
     * @param  function
     * @return this
     */
    this.replyUssdRequest = function(successCallback, errorCallback) {
        var callback = function(data) {
            try {
                data = JSON.parse(data);
            } catch(e) {};

            successCallback.call(this, data);
        };

        exec(callback, errorCallback, this.class, 'replyUssdRequest', []);

        return this;
    };
};

module.exports = Ussd;

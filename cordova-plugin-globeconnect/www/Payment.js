var exec = require('cordova/exec');

// Payment
var Payment = function(accessToken) {
    // short hand initialization
    if(!(this instanceof Payment)) {
        return new Payment(accessToken);
    }

    // class name
    this.class = 'Payment';

    // access token set?
    if(accessToken) {
        exec(null, null, this.class, 'setAccessToken', [accessToken]);
    }

    /**
     * Set app id.
     *
     * @param  string
     * @return this
     */
    this.setAppId = function(appId) {
        exec(null, null, this.class, 'setAppId', [appId]);

        return this;
    };

    /**
     * Set app secret.
     *
     * @param  string
     * @return this
     */
    this.setAppSecret = function(appSecret) {
        exec(null, null, this.class, 'setAppSecret', [appSecret]);

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
     * Set amount.
     *
     * @param  double
     * @return this
     */
    this.setAmount = function(amount) {
        exec(null, null, this.class, 'setAmount', [amount]);

        return this;
    };

    /**
     * Set description.
     *
     * @param  string
     * @return this
     */
    this.setDescription = function(description) {
        exec(null, null, this.class, 'setDescription', [description]);

        return this;
    };

    /**
     * Set end user id.
     *
     * @param  string
     * @return this
     */
    this.setEndUserId = function(endUserId) {
        exec(null, null, this.class, 'setEndUserId', [endUserId]);

        return this;
    };

    /**
     * Set reference code.
     *
     * @param  string
     * @return this
     */
    this.setReferenceCode = function(appSecret) {
        exec(null, null, this.class, 'setReferenceCode', [appSecret]);

        return this;
    };

    /**
     * Set transaction operation status.
     *
     * @param  string
     * @return this
     */
    this.setTransactionOperationStatus = function(transactionOperationStatus) {
        exec(null, null, this.class, 'setTransactionOperationStatus', [transactionOperationStatus]);

        return this;
    };

    /**
     * Send payment request.
     *
     * @param  function
     * @param  function
     * @return this
     */
    this.sendPaymentRequest = function(successCallback, errorCallback) {
        var callback = function(data) {
            try {
                data = JSON.parse(data);
            } catch(e) {};

            successCallback.call(this, data);
        };

        exec(callback, errorCallback, this.class, 'sendPaymentRequest', []);

        return this;
    };

    /**
     * Get last reference code.
     *
     * @param  function
     * @param  function
     * @return this
     */
    this.getLastReferenceCode = function(successCallback, errorCallback) {
        var callback = function(data) {
            try {
                data = JSON.parse(data);
            } catch(e) {};

            successCallback.call(this, data);
        };

        exec(callback, errorCallback, this.class, 'getLastReferenceCode', []);

        return this;
    };
};

module.exports = Payment;

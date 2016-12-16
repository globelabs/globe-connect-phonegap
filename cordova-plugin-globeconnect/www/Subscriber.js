var exec = require('cordova/exec');

// Subscriber
var Subscriber = function(accessToken) {
    // short hand initialization
    if(!(this instanceof Subscriber)) {
        return new Subscriber(accessToken);
    }

    // class name
    this.class = 'Subscriber';

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
     * Get subscriber balance.
     *
     * @param  function
     * @param  function
     * @return this
     */
    this.getSubscriberBalance = function(successCallback, errorCallback) {
        var callback = function(data) {
            try {
                data = JSON.parse(data);
            } catch(e) {};

            successCallback.call(this, data);
        };

        exec(callback, errorCallback, this.class, 'getSubscriberBalance', []);

        return this;
    };

    /**
     * Get subscriber reload amount.
     *
     * @param  function
     * @param  function
     * @return this
     */
    this.getSubscriberReloadAmount = function(successCallback, errorCallback) {
        var callback = function(data) {
            try {
                data = JSON.parse(data);
            } catch(e) {};

            successCallback.call(this, data);
        };

        exec(callback, errorCallback, this.class, 'getSubscriberReloadAmount', []);

        return this;
    };
};

module.exports = Subscriber;

var exec = require('cordova/exec');

// Location
var Location = function(accessToken) {
    // short hand initialization
    if(!(this instanceof Location)) {
        return new Location(accessToken);
    }

    // class name
    this.class = 'Location';

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
     * Set requested accuracy.
     *
     * @param  int
     * @return this
     */
    this.setRequestedAccuracy = function(requestedAccuracy) {
        exec(null, null, this.class, 'setRequestedAccuracy', [requestedAccuracy]);

        return this;
    };

    /**
     * Get location.
     *
     * @param  function
     * @param  function
     * @return this
     */
    this.getLocation = function(successCallback, errorCallback) {
        var callback = function(data) {
            try {
                data = JSON.parse(data);
            } catch(e) {};

            successCallback.call(this, data);
        };

        exec(callback, errorCallback, this.class, 'getLocation', []);

        return this;
    };
};

module.exports = Location;

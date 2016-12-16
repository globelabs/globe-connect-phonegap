var exec = require('cordova/exec');

// Authentication
var Authentication = function(appId, appSecret) {
    // short hand initialization
    if(!(this instanceof Authentication)) {
        return new Authentication(appId, appSecret);
    }

    // class name
    this.class = 'Authentication';

    // app id set?
    if(appId) {
        exec(null, null, this.class, 'setAppId', [appId]);
    };

    // app secret set?
    if(appSecret) {
        exec(null, null, this.class, 'setAppSecret', [appSecret]);
    };

    /**
     * Set app id.
     *
     * @param  string
     * @return this
     */
    this.setAppId = function(appId) {
        exec(successCallback, errorCallback, this.class, 'setAppId', [appId]);

        return this;
    };

    /**
     * Set app secret.
     *
     * @param  string
     * @return this
     */
    this.appSecret = function(appSecret) {
        exec(successCallback, errorCallback, this.class, 'setAppSecret', [appSecret]);

        return this;
    };

    /**
     * Get dialog url.
     *
     * @param  function
     * @param  function
     * @return this
     */
    this.getDialogUrl = function(successCallback, errorCallback) {
        exec(successCallback, errorCallback, this.class, 'getDialogUrl', []);

        return this;
    };

    /**
     * Get access token
     *
     * @param  string
     * @param  function
     * @param  function
     * @return this
     */
    this.getAccessToken = function(code, successCallback, errorCallback) {
        var callback = function(data) {
            try {
                data = JSON.parse(data);
            } catch(e) {};

            successCallback.call(this, data);
        };

        exec(callback, errorCallback, this.class, 'getAccessToken', [code]);

        return this;
    };
};

module.exports = Authentication;

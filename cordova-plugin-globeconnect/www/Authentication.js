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

    /**
     * Starts an authentication activity.
     *
     * @param  string
     * @param  string
     * @param  function
     * @param  function
     * @return object
     */
    this.startAuthActivity = function(appId, appSecret, successCallback, errorCallback) {
        // root authentication url
        var root = 'http://developer.globelabs.com.ph/';
        // dialog url
        var url  = 'http://developer.globelabs.com.ph/dialog/oauth?app_id=' + appId;

        // initialize our browser reference
        var ref  = cordova.InAppBrowser.open(url, '_blank', 'location=no');
        // scope reference
        var self = this;

        // on load start
        ref.addEventListener('loadstart', function(e) {});

        // on load stop
        ref.addEventListener('loadstop', function(e) {
            // we're on a new site?
            if(e.url.indexOf(root) !== 0) {
                // check the parameters
                var params = e.url.substring(e.url.indexOf('?') + 1);
                // split it
                var params = params.split('&');
                // initialize parameter handler
                var pairs  = {};

                // iterate on each parameter
                for(var i in params) {
                    // get the key value pair
                    var pair = params[i].split('=');

                    // set the key value pair
                    pairs[pair[0]] = pair[1];
                }

                self
                // set app id
                .setAppId(appId)
                // set app secret
                .setAppSecret(appSecret)
                // send get access token request
                .getAccessToken(pairs.code, function(response) {
                    // close browser
                    ref.close();

                    // clear reference
                    ref = undefined;

                    // return to callback
                    successCallback(response);
                }, function(response) {
                    errorCallback(response);
                });
            }
        });

        // on load error
        ref.addEventListener('loaderror', function(e) {
            // call error callback
            errorCallback();
        });

        return ref;
    }
};

module.exports = Authentication;

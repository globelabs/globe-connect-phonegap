var exec = require('cordova/exec');

// Amax
var Amax = function(appId, appSecret) {
    // short hand initialization
    if(!(this instanceof Amax)) {
        return new Amax(appId, appSecret);
    }

    // class name
    this.class = 'Amax';

    // app id set?
    if(appId) {
        exec(null, null, this.class, 'setAppId', [appId]);
    }

    // app secret set?
    if(appSecret) {
        exec(null, null, this.class, 'setAppSecret', [appSecret]);
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
        exec(null, null, this.class, 'setAppSecret', [appId]);

        return this;
    };

    /**
     * Set rewards token.
     *
     * @param  string
     * @return this
     */
    this.setRewardsToken = function(rewardsToken) {
        exec(null, null, this.class, 'setRewardsToken', [rewardsToken]);

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
     * Set promo.
     *
     * @param  string
     * @return this
     */
    this.setPromo = function(promo) {
        exec(null, null, this.class, 'setPromo', [promo]);

        return this;
    };

    /**
     * Send reward request.
     *
     * @param  function
     * @param  function
     * @return this
     */
    this.sendRewardRequest = function(successCallback, errorCallback) {
        var callback = function(data) {
            try {
                data = JSON.parse(data);
            } catch(e) {};

            successCallback.call(this, data);
        };

        exec(callback, errorCallback, this.class, 'sendRewardRequest', []);

        return this;
    };
};

module.exports = Amax;

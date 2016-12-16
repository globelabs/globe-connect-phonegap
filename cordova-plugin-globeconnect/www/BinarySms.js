var exec = require('cordova/exec');

// BinarySms
var BinarySms = function(senderAddress, accessToken) {
    // short hand initialization
    if(!(this instanceof BinarySms)) {
        return new BinarySms(senderAddress, accessToken);
    }

    // class name
    this.class = 'BinarySms';

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
     * Set user data header.
     *
     * @param  string
     * @return this
     */
    this.setUserDataHeader = function(userDataHeader) {
        exec(null, null, this.class, 'setUserDataHeader', [userDataHeader]);

        return this;
    };

    /**
     * Set data coding scheme
     *
     * @param  int
     * @return this
     */
    this.setDataCodingScheme = function(dataCodingScheme) {
        exec(null, null, this.class, 'setDataCodingScheme', [dataCodingScheme]);

        return this;
    };

    /**
     * Set binary message.
     *
     * @param  string
     * @return this
     */
    this.setBinaryMessage = function(binaryMessage) {
        exec(null, null, this.class, 'setBinaryMessage', [binaryMessage]);

        return this;
    };

    /**
     * Send binary message
     *
     * @param  function
     * @param  function
     * @return this
     */
    this.sendBinaryMessage = function(successCallback, errorCallback) {
        var callback = function(data) {
            try {
                data = JSON.parse(data);
            } catch(e) {};

            successCallback.call(this, data);
        };

        exec(callback, errorCallback, this.class, 'sendBinaryMessage', []);

        return this;
    };
};

module.exports = BinarySms;

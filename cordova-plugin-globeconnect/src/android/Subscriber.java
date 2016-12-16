/* 
 * The MIT License
 *
 * Copyright 2016 charleszamora.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package ph.com.globe.connect;

import java.net.URISyntaxException;

import org.apache.http.client.utils.URIBuilder;

import org.json.JSONArray;
import org.json.JSONException;

import org.apache.cordova.CallbackContext;

/**
 * Subscriber Data Query.
 * 
 * @author Charles Zamora czamora@openovate.com
 */
public class Subscriber extends Context {
    /* Subscriber url */
    private final String SUBSCRIBER_URL = "https://devapi.globelabs.com.ph/location/v1/queries/balance";
    
    /* Subscriber reload amount url */
    private final String SUBSCRIBER_RA_URL = "https://devapi.globelabs.com.ph/location/v1/queries/reload_amount";
    
    /* API Access token */
    protected String accessToken = null;
    
    /* Subscribers address */
    protected String address = null;
    
    /**
     * Create Subscriber class without parameters.
     */
    public Subscriber() {
    }
    
    /**
     * Create Subscriber class with access
     * token parameter.
     * 
     * @param accessToken access token
     */
    public Subscriber(String accessToken) {
        // set access token
        this.accessToken = accessToken;
    }
    
    /**
     * Sets access token.
     * 
     * @param  accessToken access token
     * @return this
     */
    public Subscriber setAccessToken(String accessToken) {
        // set access token
        this.accessToken = accessToken;
        
        return this;
    }
    
    /**
     * Set subscriber address.
     * 
     * @param  address subscriber address
     * @return this
     */
    public Subscriber setAddress(String address) {
        // set address
        this.address = address;
        
        return this;
    }
    
    /**
     * Get subscriber balance request.
     * 
     * @param  address subscriber address
     * @param  asyncHandler
     * @return void
     * @throws ApiException api exception
     * @throws HttpRequestException http request exception
     * @throws HttpResponseException http response exception
     */
    public void getSubscriberBalance(String address, AsyncHandler asyncHandler)
        throws ApiException, HttpRequestException, HttpResponseException {
        
        // set request url
        String url = this.SUBSCRIBER_URL;
        
        // build url
        try {
            // initialize url builder
            URIBuilder builder = new URIBuilder(url);
            
            // set access token parameter
            builder.setParameter("access_token", this.accessToken);
            // set the address
            builder.setParameter("address", address);
            
            // build the url
            url = builder.build().toString();
        } catch(URISyntaxException e) {
            // throw exception
            throw new ApiException(e.getMessage());
        }

        // send request
        new HttpRequest()
        // set url
        .setUrl(url)
        // set async handler
        .setAsyncHandler(asyncHandler)
        // send get request
        .execute("get");
    }
    
    /**
     * Get subscriber balance request.
     *
     * @param  asyncHandler
     * @return void
     * @throws ApiException api exception
     * @throws HttpRequestException http request exception
     * @throws HttpResponseException  http response exception
     */
    public void getSubscriberBalance(AsyncHandler asyncHandler)
        throws ApiException, HttpRequestException, HttpResponseException {
        
        // call get subscriber balance
        this.getSubscriberBalance(this.address, asyncHandler);
    }
    
    /**
     * Get subscriber reload amount.
     * 
     * @param  address subscriber address
     * @param  asyncHandler
     * @return void
     * @throws ApiException api exception
     * @throws HttpRequestException http request exception
     * @throws HttpResponseException http response exception
     */
    public void getSubscriberReloadAmount(String address, AsyncHandler asyncHandler)
        throws ApiException, HttpRequestException, HttpResponseException {
        
        // set request url
        String url = this.SUBSCRIBER_RA_URL;
        
        // build url
        try {
            // initialize url builder
            URIBuilder builder = new URIBuilder(url);
            
            // set access token parameter
            builder.setParameter("access_token", this.accessToken);
            // set the address
            builder.setParameter("address", address);
            
            // build the url
            url = builder.build().toString();
        } catch(URISyntaxException e) {
            // throw exception
            throw new ApiException(e.getMessage());
        }

        // send request
        new HttpRequest()
        // set url
        .setUrl(url)
        // set async handler
        .setAsyncHandler(asyncHandler)
        // send get request
        .execute("get");
    }
    
    /**
     * Get subscriber reload amount.
     *
     * @param  asyncHandler
     * @return void
     * @throws ApiException api exception
     * @throws HttpRequestException http request exception
     * @throws HttpResponseException http response exception
     */
    public void getSubscriberReloadAmount(AsyncHandler asyncHandler)
        throws ApiException, HttpRequestException, HttpResponseException {
        
        // call get subscriber reload amount
        this.getSubscriberReloadAmount(this.address, asyncHandler);
    }

    /**
     * Process the execute command from cordova.
     *
     * @param  action
     * @param  args
     * @param  callbackContext
     * @return boolean
     * @throws JSONException
     */
    @Override
    public boolean execute(
        final String action, 
        JSONArray args, 
        final CallbackContext callbackContext) 
        throws JSONException {

        // try building
        try {
            // set access token?
            if("setAccessToken".equals(action)) {
                // call set access token
                this.setAccessToken(args.get(0).toString());

            // set address?
            } else if("setAddress".equals(action)) {
                // call set client correlator
                this.setAddress(args.get(0).toString());

            // get subscriber balance?
            } else if("getSubscriberBalance".equals(action)) {
                // try building
                try {
                    // call get subscriber balance
                    this.getSubscriberBalance(
                        new AsyncHandler() {
                        @Override
                        public void response(HttpResponse response) throws HttpResponseException {
                            // try parsing
                            try {
                                // send response
                                callbackContext.success(response.getJsonResponse());
                            } catch(HttpResponseException e) {
                                callbackContext.error(e.getMessage());
                            }
                        }
                    });
                } catch(HttpRequestException e) {
                    callbackContext.error(e.getMessage());
                } catch(HttpResponseException e) {
                    callbackContext.error(e.getMessage());
                }

            // get subscriber reload amount
            } else if("getSubscriberReloadAmount".equals(action)) {
                // try building
                try {
                    // call get subscriber reload amount
                    this.getSubscriberReloadAmount(
                        new AsyncHandler() {
                        @Override
                        public void response(HttpResponse response) throws HttpResponseException {
                            // try parsing
                            try {
                                // send response
                                callbackContext.success(response.getJsonResponse());
                            } catch(HttpResponseException e) {
                                callbackContext.error(e.getMessage());
                            }
                        }
                    });
                } catch(HttpRequestException e) {
                    callbackContext.error(e.getMessage());
                } catch(HttpResponseException e) {
                    callbackContext.error(e.getMessage());
                }
            }
        } catch(ApiException e) {
            callbackContext.error(e.getMessage());
        }

        return true;
    }
}

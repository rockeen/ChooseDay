//
//  MLPayConstants.h
//  MaxLeapPay
//

#ifndef MLPayConstants_h
#define MLPayConstants_h

#import <Foundation/Foundation.h>

//----------------------------------------
//  @name Pay Environment
//----------------------------------------

/**
 *  MaxLeap pay environment. Some channels like alipay, only support production envrionment.
 */
typedef NS_ENUM(int, MLPayEnvironment) {
    /** production envrionment */
    MLPayEnvironmentProduction = 0,
    
    /** sandbox environment, connection to sandbox servers to process transaction */
    MLPayEnvironmentSandbox,
    
    /** offline environment, using mock data */
    MLPayEnvironmentOffline
};

//----------------------------------------
//  @name Pay Channels Defination
//----------------------------------------

/**
 *  MaxLeap Pay Channels
 */
typedef NS_ENUM(int, MLPayChannel) {
    /** No channel */
    MLPayChannelNone = 0,
    
    /** Alipay */
    MLPayChannelAli = 10,
    
    /** 支付宝移动支付 */
    MLPayChannelAliApp,
    
    /** 支付宝网页即时到帐 */
    MLPayChannelAliWeb,
    
    /** 支付宝扫码即时到帐 */
    MLPayChannelAliQrcode,
    
    /** Wechat pay */
    MLPayChannelWx = 20,
    
    /** Wechat pay app */
    MLPayChannelWxApp,
    
    /** 微信 jsapi(H5) */
    MLPayChannelWxJsapi,
    
    /** Paypal */
    MLPayChannelPayPal = 30,
    
    /** Amazon */
    MLPayChannelAmazon = 40,
    
    /** 银联 */
    MLPayChannelUnipay = 50,
    
    /** 银联移动支付 */
    MLPayChannelUnipayApp,
    
    /** 银联网页支付 */
    MLPayChannelUnipayWeb
};

FOUNDATION_EXPORT NSString * NSStringFromMLPayChannel(MLPayChannel channel);
FOUNDATION_EXPORT MLPayChannel MLPayChannelFromString(NSString *channelStr);

//----------------------------------------
//  @name Return Code
//----------------------------------------

/**
 *  MaxLeap Pay Error Domain
 */
FOUNDATION_EXPORT NSString *const MLPayErrorDomain;

/**
 *  MaxLeap pay result codes
 */
typedef NS_ENUM(NSInteger, MLPayResultCode) {
    /** @abstract 0: pay succeed */
    MLPaySuccess = 0,
    
    /** @abstract -1: Unknown error, no information avaiable. */
    MLPayErrorUnknown = -1,
    
    /** @abstract -2: Transaction was cancelled by user */
    MLPayErrorUserCancel = -2,
    
    /** @abstract -3: Transaction failed, parameter invalid or connection failed */
    MLPayErrorSentFail = -3,
    
    /** @abstract -4: Channel or environment not supported */
    MLPayErrorUnsupport = -4,
    
    /** @abstract 1: App invalid */
    MLPayErrorAppInvalid = 1,
    
    /** @abstract 2: Pay factor not set on cloud servers */
    MLPayErrorPayFactorNotSet = 2,
    
    /** @abstract 3: Channel invalid */
    MLPayErrorChannelInvalid = 3,
    
    /** @abstract 4: Some parameters missing */
    MLPayErrorMissParam = 4,
    
    /** @abstract 5: Parameter is invalid */
    MLPayErrorParamInvalid = 5,
    
    /** @abstract 6: Certificate file error */
    MLPayErrorCertFileError = 6,
    
    /** @abstract 7: Channel error */
    MLPayErrorChannelError = 7,
    
    /** @abstract 14: Server runtime error, please contact technical support engineer */
    MLPayErrorRuntimeError = 14
};

#endif /* MLPayConstants_h */

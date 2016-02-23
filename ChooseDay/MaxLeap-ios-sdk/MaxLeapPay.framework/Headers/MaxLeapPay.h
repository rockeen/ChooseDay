//
//  MaxLeapPay.h
//  MaxLeapPay
//

#import <MaxLeap/MaxLeap.h>
#import <MaxLeapPay/MLPayment.h>
#import <MaxLeapPay/MLPayResult.h>
#import <MaxLeapPay/MLOrder.h>

NS_ASSUME_NONNULL_BEGIN

@class PayResp;
@protocol WXApiDelegate;

/**
 *  The main SDK class of `MaxLeapPay` framework.
 */
@interface MaxLeapPay : NSObject

//------------------------------------------------
// @name MaxLeapPay Configuration
//------------------------------------------------

/**
 *  Set the payment environment.
 *
 *  @discussion Not all channel support all the environments. You can check whether a channel is avalibale by using method `isChannelAvaliable:`.
 *
 *  @param environment the environment
 */
+ (void)setEnvironment:(MLPayEnvironment)environment;

/**
 *  Check whether a channel is avaliable.
 *
 *  @discussion An avaliable channel may satisfy several conditions simutanously.
 *              1. The sdk for this channel is intergrated.
 *              2. Set credentials correctly if needed.
 *              3. PayEnvironment you set is suported.
 *
 *  @param channel The channel to check.
 *
 *  @return `YES` if avaliable, otherwise `NO`.
 */
+ (BOOL)isChannelAvaliable:(MLPayChannel)channel;

//------------------------------------------------
// @name Channel Configuration
//------------------------------------------------

/**
 *  Initialize WeChat pay environment by calling `+[WXApi registerApp:withDescription:]`.
 *
 *  @param appId       wechat appid
 *  @param wxDelegate  an object confirms to WXApiDelegate protocol
 *  @param description wechat description
 *
 *  @return YES if appId and wxDelegate are invalid.
 */
+ (BOOL)setWXAppId:(NSString *)appId wxDelegate:(id<WXApiDelegate>)wxDelegate description:(nullable NSString *)description;

//------------------------------------------------
// @name Actions
//------------------------------------------------

/**
 *  Start the payment.
 *  After transaction completion, the block will be execute on main thread and bring the result.
 *  You can check `result.code` to find out whether the transaction success or not.
 *
 *  @param payment The payment must be properly configured.
 *  @param block   Block to execute after transaction finish. It should have the following signature:(MLPayResult *result)
 */
+ (void)startPayment:(MLPayment *)payment completion:(MLPayResultBlock)block;

/**
 *  Some channel(eg. alipayapp) will open their official app to process the transaction.
 *  After the transaction finish, their official app will inform the transaction result by `openURL:`
 *  So, it is important for you to call this method in `application:openURL:sourceApplication:annotation:` or `application:openURL:options:`.
 *
 *  @param URL   The url passed in by `application:openURL:xxx`.
 *  @param block If your app is killed after opening another app to process the transaction, the block will be executed on main queue.
 *
 *  @return Whether the `URL` can be handled.
 */
+ (BOOL)handleOpenUrl:(NSURL *)URL completion:(MLPayResultBlock)block;

/**
 *  @abstract Handle the wechat pay response to complete the wechat pay process.
 *
 *  @discussion This method result in a `MLUser` logging in or creating. And then the block in method `startPayment:completion:` will be excuted on main thread.
 *  You should call this method when receive the `SendAuthResp` response.
 *
 *  @param response The `PayResp` received in WXApiDelegate method 'onResp:'.
 */
+ (void)handleWXPayResponse:(PayResp *)response;

/**
 *  Fetch the order infomation.
 *  
 *  @discussion This api can be used to verify the authenticity of a transaction by check `status` of the order. The valid order status is `pay`.
 *
 *  @param billNo  The `billNo` of the order to query.
 *  @param channel The channel of the order.
 *  @param block   Block callback to bring the query result. It should have the following signature: (MLOrder *order, NSError *error).
 */
+ (void)queryOrderWithBillNo:(NSString *)billNo andChannel:(MLPayChannel)channel block:(MLOrderResultBlock)block;

/**
 *  Query orders with the billNo.
 *
 *  @discussion Orders in different channel may have the same bill No.
 *  This api can be used to verify the authenticity of a transaction by check `status` of the order. The valid order status is `pay`.
 *
 *  @param billNo  The `billNo` of the order to query.
 *  @param block   Block callback to bring the query result. It should have the following signature: (NSArray <MLOrder*> *orderList, NSError *error).
 */
+ (void)queryOrderWithBillNo:(NSString *)billNo block:(MLArrayResultBlock)block;

@end

NS_ASSUME_NONNULL_END

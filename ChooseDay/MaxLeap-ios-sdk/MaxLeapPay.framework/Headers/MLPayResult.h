//
//  MLPayResult.h
//  MaxLeapPay
//

#import <Foundation/Foundation.h>
#import <MaxLeapPay/MLPayConstants.h>
#import <MaxLeapPay/MLPayment.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  The representation of transaction result.
 */
@interface MLPayResult : NSObject

/**
 *  The error occured in transaction.
 */
@property (nullable, nonatomic, strong) NSError *error;

/**
 *  The transaction result code. `MLPaySuccess` indicate the transaction success, otherwise an error occurred.
 */
@property (nonatomic) MLPayResultCode code;

/**
 *  Detail result information returned by payment sdk.
 */
@property (nullable, nonatomic, strong) NSDictionary *infoDict;

/**
 *  Pay channel
 */
@property (nonatomic) MLPayChannel channel;

/**
 *  The payment object.
 */
@property (readonly, nullable, nonatomic, strong) MLPayment *payment;

/**
 *  Create the result instance of the payment.
 *
 *  @param payment a payment.
 *
 *  @return a new result instance for the payment.
 */
+ (instancetype)resultWithPayment:(nullable MLPayment *)payment;

@end

typedef void (^MLPayResultBlock)(MLPayResult *result);

NS_ASSUME_NONNULL_END

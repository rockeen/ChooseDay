//
//  MLPayment.h
//  MaxLeapPay
//

#import <MaxLeapPay/MLPayConstants.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  The represent of payment infomation.
 */
@interface MLPayment : NSObject

/**
 *  (Required) The channel of disbursement. Default is `MLPayChannelNone`.
 */
@property (nonatomic) MLPayChannel channel;

/**
 *  (Required) The bill number of the payment, unique in your merchant system.
 */
@property (nonatomic, copy) NSString *billNo;

/**
 *  (Required) The total fee of this payment, in cent.
 */
@property (nonatomic) NSInteger totalFee; // 单位为分

/**
 *  (Required) The brief description of this payment.
 */
@property (nonatomic, copy) NSString *subject;

/**
 *  (Optional) Some extra attributes.
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *extraAttrs;

/**
 *  (Optional, Required by alipay channels) The scheme used by alipay.
 */
@property (nonatomic, copy, nullable) NSString *scheme;

@end

NS_ASSUME_NONNULL_END

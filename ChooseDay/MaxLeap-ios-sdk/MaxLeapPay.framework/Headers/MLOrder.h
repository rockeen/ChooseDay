//
//  MLOrder.h
//  MaxLeapPay
//
//  Created by Sun Jin on 12/30/15.
//  Copyright © 2015 maxleap. All rights reserved.
//

#import <MaxLeapPay/MLPayConstants.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLOrder : NSObject

/**
 *  Order id.
 */
@property (readonly, nonatomic) NSString *orderId;

/**
 *  bill number
 */
@property (readonly, nonatomic) NSString *billNo;

/**
 *  pay channel
 */
@property (readonly, nonatomic) MLPayChannel channel;

/**
 *  currency type
 */
@property (readonly, nonatomic) NSString *currency;

/**
 *  total fee description
 */
@property (readonly, nonatomic) NSString *money;

/**
 *  number of total fee, in cent.
 */
@property (readonly, nonatomic) NSInteger totalFee;

/**
 *  Status of the order. It has three values, "created", "pay", "refund".
 */
@property (readonly, nonatomic) NSString *status;

/**
 *  Original data of the order.
 */
@property (readonly, nonatomic) NSDictionary *infoDictionary;

/**
 *  Create a `MLOrder` instance using a given dictionary.
 *
 *  @param dictionary Original data of the order.
 *
 *  @return An instance of `MLOrder`.
 */
+ (instancetype)orderFromDictionary:(NSDictionary *)dictionary;

@end

typedef void (^MLOrderResultBlock)(MLOrder * __nullable order, NSError * __nullable error);


NS_ASSUME_NONNULL_END

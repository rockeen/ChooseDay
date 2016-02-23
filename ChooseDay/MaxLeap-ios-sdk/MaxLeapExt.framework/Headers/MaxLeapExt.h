//
//  MaxLeapExt.h
//  MaxLeapExt
//


#ifndef EXTENSION_IOS
    #error Please define "EXTENSION_IOS" in "your_extension_target >> Build Settings >> Preprocessor Macros"
#endif

#import <MaxLeapExt/MLConstants.h>
#import <MaxLeapExt/MLRelation.h>
#import <MaxLeapExt/MLGeoPoint.h>
#import <MaxLeapExt/MLObject.h>
#import <MaxLeapExt/MLSubclassing.h>
#import <MaxLeapExt/MLObject+Subclass.h>
#import <MaxLeapExt/MLQuery.h>
#import <MaxLeapExt/MLInstallation.h>
#import <MaxLeapExt/MLUser.h>
#import <MaxLeapExt/MLAnonymousUtils.h>
#import <MaxLeapExt/MLSmsCodeUtils.h>
#import <MaxLeapExt/MLCloudCode.h>
#import <MaxLeapExt/MLFile.h>
#import <MaxLeapExt/MLPrivateFile.h>
#import <MaxLeapExt/MLConfig.h>
#import <MaxLeapExt/MLEmail.h>
#import <MaxLeapExt/MLReceiptManager.h>
#import <MaxLeapExt/MLLogger.h>
#import <MaxLeapExt/MLAnalytics.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 The main SDK class to config MaxLeap framework.
 */
@interface MaxLeap : NSObject

/**
 *  Sets the applicationId, clientKey and site of your application.
 *
 *  @param applicationId The application id for your MaxLeap application.
 *  @param clientKey     The client key for your MaxLeap application.
 *  @param site          One of the enumerator constants MLSiteUS (United States), MLSiteCN (Japan) based on your desired location.
 */
+ (void)setApplicationId:(NSString *)applicationId clientKey:(NSString *)clientKey site:(MLSite)site;

/*!
 The current application id that was used to configure MaxLeap framework.
 */
+ (NSString *)applicationId;

/*!
 The current client key that was used to configure MaxLeap framework.
 */
+ (NSString *)clientKey;

/**
 *  get the timeout interval for MaxLeap request
 *
 *  @return timeout interval
 */
+ (NSTimeInterval)networkTimeoutInterval;

/**
 *  set the timeout interval for MaxLeap request
 *
 *  @param timeoutInterval timeout interval
 */
+ (void)setNetworkTimeoutInterval:(NSTimeInterval)timeoutInterval;

@end

NS_ASSUME_NONNULL_END


//
//  MLAnalytics.h
//  MaxLeap
//


#import <MaxLeapExt/MLConstants.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 MLAnalytics provides an interface toMaxLeap's logging and analytics backend.<br>
 <br>
 Methods will return immediately and cache the request (+ timestamp) to be handled "eventually." That is, the request will be sent immediately if possible or the next time a network connection is available otherwise.
 */
@interface MLAnalytics : NSObject

#pragma mark -

/** @name Open / Close a MaxLeap session */

/** Open a new session.
 *
 *  @discution MaxLeap SDK observe UIApplication notifications in +[MaxLeap setApplicationId:clientKey:] method. Call open/closeSession only if these notifications cannot be observed, eg: in an app-extension.
 *
 *  @notice This method should be called after +[MaxLeap setApplicationId:clientKey:].
 */
+ (void)openSession;

/**
 *  Close the current session and send statistics data.
 *
 *  @note MaxLeap SDK observe UIApplication notifications in +[MaxLeap setApplicationId:clientKey:] method. Call open/closeSession only if these notifications cannot be observed, eg: in an app-extension.
 */
+ (void)closeSession;

/**
 *  Set the timeout for expiring a MaxLeap session.
 *
 *  This is an optional method that sets the time the app may be in the background before
 *  starting a new session upon resume.  The default value for the session timeout is 0
 *  seconds in the background.
 *
 *  @param seconds The time in seconds to set the session timeout to.
 */
+ (void)setSessionContinueSeconds:(int)seconds;

#pragma mark -
/** @name Custom Analytics */

/*!
 Tracks the occurrence of a custom event. MaxLeap will store a data point at the time of invocation with the given event name.
 
 @param name The name of the custom event to report to MaxLeap as having happened.
 */
+ (void)trackEvent:(NSString *)name;

/**
 *  Tracks the occurrence of a custom event. MaxLeap will store a data point at the time of invocation with the given event name.
 *
 *  @param name  The name of the custom event to report to MaxLeap as having happened.
 *  @param count The number of this event occurred.
 */
+ (void)trackEvent:(NSString *)name count:(int)count;

/**
 *  Tracks the occurrence of a custom event with additional parameters.<br>
 *
 *  Event parameters can be used to provide additional information about the event. The parameters is a dictionary containing Key-Value pairs of parameters. Keys and values should be NSStrings.<br>
 *
 *  The following is a sample to track a purchase with additional parameters:<br>
 *
 *  @code
 *  NSDictionary *parameters = @{@"productName": @"iPhone 6s",
 *                               @"productCategory": @"electronics"};
 *  [MLAnalytics trackEvent:@"productPurchased" parameters:parameters];
 *  @endcode
 *
 *  @param name       The name of the custom event.
 *  @param parameters The dictionary of additional information for this event.
 */
+ (void)trackEvent:(NSString *)name parameters:(nullable NSDictionary ML_GENERIC(NSString*, NSString*) *)parameters;

/**
 *  Tracks the occurrence of a custom event with additional parameters.<br>
 *
 *  Event parameters can be used to provide additional information about the event. The parameters is a dictionary containing Key-Value pairs of parameters. Keys and values should be NSStrings.<br>
 *
 *  The following is a sample to track a purchase with additional parameters:<br>
 *
 *  @code
 *  NSDictionary *parameters = @{@"productName": @"iPhone 6s",
 *                               @"productCategory": @"electronics"};
 *  [MLAnalytics trackEvent:@"productPurchased" parameters:parameters];
 *  @endcode
 *
 *  @param name       The name of the custom event.
 *  @param parameters The dictionary of additional information for this event.
 *  @param count      The number of this event occurred.
 */
+ (void)trackEvent:(NSString *)name parameters:(nullable NSDictionary ML_GENERIC(NSString*, NSString*) *)parameters count:(int)count;

#pragma mark -
/** @name Page View Analytics */

/**
 *  Tracks the duration of view displayed.
 *
 *  Tracks the beginning of view display.
 *
 *  @param pageName The name of the page.
 */
+ (void)beginLogPageView:(NSString *)pageName;

/**
 *  Tracks the duration of view displayed.
 *
 *  Tracks the ending of view display.
 *
 *  @param pageName The name of the page.
 */
+ (void)endLogPageView:(NSString *)pageName;

@end

NS_ASSUME_NONNULL_END

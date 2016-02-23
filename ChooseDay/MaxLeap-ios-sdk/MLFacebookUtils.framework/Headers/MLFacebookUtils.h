//
//  MLFacebookUtils.h
//  MaxLeap
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import <MaxLeap/MaxLeap.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 Provides utility functions for working with Facebook in a MaxLeap application.<br>
 
 This class is currently for iOS only.
 */
@interface MLFacebookUtils : NSObject

/** @name Interacting With Facebook */

/*!
 Gets the Facebook session for the current user.
 */
+ (nullable FBSession *)session;

/*!
 Initializes the Facebook singleton. You must invoke this in order to use the Facebook functionality in MaxLeap. You must provide your Facebook application ID as the value for FacebookAppID in your bundle's plist file as described here: https://developers.facebook.com/docs/getting-started/facebook-sdk-for-ios/
 */
+ (void)initializeFacebook;

/*!
 Initializes the Facebook singleton. You must invoke this in order to use the Facebook functionality in MaxLeap. You must provide your Facebook application ID as the value for FacebookAppID in your bundle's plist file as described here: https://developers.facebook.com/docs/getting-started/facebook-sdk-for-ios/
 
 @param urlSchemeSuffix The URL suffix for this application - used when multiple applications with the same Facebook application ID may be on the same device.
 */
+ (void)initializeFacebookWithUrlShemeSuffix:(nullable NSString *)urlSchemeSuffix;

/*!
 Whether the user has their account linked to Facebook.
 
 @param user User to check for a facebook link. The user must be logged in on this device.
 
 @return True if the user has their account linked to Facebook.
 */
+ (BOOL)isLinkedWithUser:(nullable MLUser *)user;

/** @name Logging In & Creating Facebook-Linked Users */

/*!
 Logs in a user using Facebook. This method delegates to the Facebook SDK to authenticate the user, and then automatically logs in (or creates, in the case where it is a new user) a MLUser.
 
 @param permissions The permissions required for Facebook log in. This passed to the authorize method on the Facebook instance.
 @param block       The block to execute. The block should have the following argument signature: (MLUser *user, NSError *error)
 */
+ (void)logInWithPermissions:(NSArray ML_GENERIC(NSString *) *)permissions block:(nullable MLUserResultBlock)block;

/*!
 Logs in a user using Facebook. Allows you to handle user login to Facebook, then provide authentication data to log in (or create, in the case where it is a new user) the MLUser.
 
 @param facebookId      The id of the Facebook user being linked
 @param accessToken     The access token for the user's session
 @param expirationDate  The expiration date for the access token
 @param block           The block to execute. The block should have the following argument signature: (MLUser *user, NSError *error)
 */
+ (void)logInWithFacebookId:(NSString *)facebookId
                accessToken:(NSString *)accessToken
             expirationDate:(NSDate *)expirationDate
                      block:(nullable MLUserResultBlock)block;

/** @name Linking Users with Facebook */

/*!
 Links Facebook to an existing MLUser. This method delegates to the Facebook SDK to authenticate the user, and then automatically links the account to the MLUser.
 
 @param user        User to link to Facebook.
 @param permissions The permissions required for Facebook log in. This passed to the authorize method on the Facebook instance.
 @param block       The block to execute. The block should have the following argument signature: (BOOL *success, NSError *error)
 */
+ (void)linkUser:(MLUser *)user permissions:(NSArray ML_GENERIC(NSString *) *)permissions block:(nullable MLBooleanResultBlock)block;

/*!
 Links Facebook to an existing MLUser. Allows you to handle user login to Facebook, then provide authentication data to link the account to the MLUser.
 
 @param user            User to link to Facebook.
 @param facebookId      The id of the Facebook user being linked
 @param accessToken     The access token for the user's session
 @param expirationDate  The expiration date for the access token
 @param block           The block to execute. The block should have the following argument signature: (BOOL *success, NSError *error)
 */
+ (void)linkUser:(MLUser *)user
      facebookId:(NSString *)facebookId
     accessToken:(NSString *)accessToken
  expirationDate:(NSDate *)expirationDate
           block:(nullable MLBooleanResultBlock)block;

/** @name Unlinking Users from Facebook */

/*!
 Makes an asynchronous request to unlink a user from a Facebook account.
 
 @param user    User to unlink from Facebook.
 @param block   The block to execute. The block should have the following argument signature: (BOOL succeeded, NSError *error)
 */
+ (void)unlinkUserInBackground:(MLUser *)user block:(nullable MLBooleanResultBlock)block;

/** @name Obtaining new permissions */

/*!
 Requests new Facebook publish permissions for the given user.  This may prompt the user to reauthorize the application. The user will be saved as part of this operation.
 
 @param user        User to request new permissions for.  The user must be linked to Facebook.
 @param permissions The new publishing permissions to request.
 @param audience    The default audience for publishing permissions to request.
 @param block       The block to execute. The block should have the following argument signature: (BOOL succeeded, NSError *error)
 */
+ (void)reauthorizeUser:(MLUser *)user
 withPublishPermissions:(NSArray ML_GENERIC(NSString *) *)permissions
               audience:(FBSessionDefaultAudience)audience
                  block:(nullable MLBooleanResultBlock)block;

@end

NS_ASSUME_NONNULL_END

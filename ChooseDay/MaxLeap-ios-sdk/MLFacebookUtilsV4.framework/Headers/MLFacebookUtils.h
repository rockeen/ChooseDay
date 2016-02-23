//
//  MLFacebookUtils.h
//  MLFacebookUtilsV4
//


#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import <MaxLeap/MaxLeap.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 The `MLFacebookUtils` class provides utility functions for using Facebook authentication with <MLUser>s.
 
 @warning This class supports official Facebook iOS SDK v4.0+ and is available only on iOS.
 */
@interface MLFacebookUtils : NSObject

///--------------------------------------
/// @name Interacting With Facebook
///--------------------------------------

/*!
 @abstract Initializes MaxLeap Facebook Utils.
 
 @discussion You must provide your Facebook application ID as the value for FacebookAppID in your bundle's plist file
 as described here: https://developers.facebook.com/docs/getting-started/facebook-sdk-for-ios/
 
 @warning You must invoke this in order to use the Facebook functionality in MaxLeap.
 
 @param launchOptions The launchOptions as passed to [UIApplicationDelegate application:didFinishLaunchingWithOptions:].
 */
+ (void)initializeFacebookWithApplicationLaunchOptions:(nullable NSDictionary *)launchOptions;

/*!
 @abstract `FBSDKLoginManager` provides methods for configuring login behavior, default audience
 and managing Facebook Access Token.
 
 @returns An instance of `FBSDKLoginManager` that is used by `MLFacebookUtils`.
 */
+ (nullable FBSDKLoginManager *)facebookLoginManager;

///--------------------------------------
/// @name Logging In
///--------------------------------------

/*!
 @abstract *Asynchronously* logs in a user using Facebook with read permissions.
 
 @discussion This method delegates to the Facebook SDK to authenticate the user,
 and then automatically logs in (or creates, in the case where it is a new user) a <MLUser>.
 
 @param permissions Array of read permissions to use.
 @param block       The block to execute when the log in completes.
 It should have the following signature: `^(MLUser *user, NSError *error)`.
 */
+ (void)logInInBackgroundWithReadPermissions:(NSArray ML_GENERIC(NSString*) *)permissions
                                       block:(nullable MLUserResultBlock)block;

/*!
 @abstract *Asynchronously* logs in a user using Facebook with publish permissions.
 
 @discussion This method delegates to the Facebook SDK to authenticate the user,
 and then automatically logs in (or creates, in the case where it is a new user) a <MLUser>.
 
 @param permissions Array of publish permissions to use.
 @param block       The block to execute when the log in completes.
 It should have the following signature: `^(MLUser *user, NSError *error)`.
 */
+ (void)logInInBackgroundWithPublishPermissions:(NSArray ML_GENERIC(NSString*) *)permissions
                                          block:(nullable MLUserResultBlock)block;

/*!
 @abstract *Asynchronously* logs in a user using given Facebook Acess Token.
 
 @discussion This method delegates to the Facebook SDK to authenticate the user,
 and then automatically logs in (or creates, in the case where it is a new user) a <MLUser>.
 
 @param accessToken An instance of `FBSDKAccessToken` to use when logging in.
 @param block       The block to execute when the log in completes.
 It should have the following signature: `^(MLUser *user, NSError *error)`.
 */
+ (void)logInInBackgroundWithAccessToken:(FBSDKAccessToken *)accessToken
                                   block:(nullable MLUserResultBlock)block;

///--------------------------------------
/// @name Linking Users
///--------------------------------------

/*!
 @abstract *Asynchronously* links Facebook with read permissions to an existing <MLUser>.
 
 @discussion This method delegates to the Facebook SDK to authenticate
 the user, and then automatically links the account to the <MLUser>.
 It will also save any unsaved changes that were made to the `user`.
 
 @param user        User to link to Facebook.
 @param permissions Array of read permissions to use.
 @param block       The block to execute when the linking completes.
 It should have the following signature: `^(BOOL succeeded, NSError *error)`.
 */
+ (void)linkUserInBackground:(MLUser *)user
         withReadPermissions:(NSArray ML_GENERIC(NSString *) *)permissions
                       block:(nullable MLBooleanResultBlock)block;

/*!
 @abstract *Asynchronously* links Facebook with publish permissions to an existing <MLUser>.
 
 @discussion This method delegates to the Facebook SDK to authenticate
 the user, and then automatically links the account to the <MLUser>.
 It will also save any unsaved changes that were made to the `user`.
 
 @param user        User to link to Facebook.
 @param permissions Array of publish permissions to use.
 @param block       The block to execute when the linking completes.
 It should have the following signature: `^(BOOL succeeded, NSError *error)`.
 */
+ (void)linkUserInBackground:(MLUser *)user
      withPublishPermissions:(NSArray ML_GENERIC(NSString*) *)permissions
                       block:(nullable MLBooleanResultBlock)block;

/*!
 @abstract *Asynchronously* links Facebook Access Token to an existing <MLUser>.
 
 @discussion This method delegates to the Facebook SDK to authenticate
 the user, and then automatically links the account to the <MLUser>.
 It will also save any unsaved changes that were made to the `user`.
 
 @param user        User to link to Facebook.
 @param accessToken An instance of `FBSDKAccessToken` to use.
 @param block       The block to execute when the linking completes.
 It should have the following signature: `^(BOOL succeeded, NSError *error)`.
 */
+ (void)linkUserInBackground:(MLUser *)user
             withAccessToken:(FBSDKAccessToken *)accessToken
                       block:(nullable MLBooleanResultBlock)block;

/*!
 @abstract Unlinks the <MLUser> from a Facebook account *asynchronously*.
 
 @param user User to unlink from Facebook.
 @param block The block to execute.
 It should have the following argument signature: `^(BOOL succeeded, NSError *error)`.
 */
+ (void)unlinkUserInBackground:(MLUser *)user block:(nullable MLBooleanResultBlock)block;

///--------------------------------------
/// @name Getting Linked State
///--------------------------------------

/*!
 @abstract Whether the user has their account linked to Facebook.
 
 @param user User to check for a facebook link. The user must be logged in on this device.
 
 @returns `YES` if the user has their account linked to Facebook, otherwise `NO`.
 */
+ (BOOL)isLinkedWithUser:(nullable MLUser *)user;

@end

NS_ASSUME_NONNULL_END

//
//  MLWeiboUtils.h
//  MLWeiboUtils
//

#import <MaxLeap/MaxLeap.h>
#import <MLWeiboUtils/MLWeiboAccessToken.h>

@class WBAuthorizeResponse;

/**
 Provides utility functions for working with Weibo in a MaxLeap application.<br>
 
 This class is currently for iOS only.
 */
@interface MLWeiboUtils : NSObject

///--------------------------------------
/// @name Interacting With Weibo
///--------------------------------------

/**
 *  @abstract Initializes MaxLeap Weibo Utils.
 *
 *  @warning You must invoke this in order to use the Weibo functionality in MaxLeap.
 *  @warning The apis below are only available when `+[WeiboSDK regiterAppKey:]` successfully.
 *
 *  @param appKey      Your weibo app key.
 *  @param redirectURI @see WBAuthorizeRequest.redirectURI in WeiboSDK.h
 *
 *  @return Return the value returned by `+[WeiboSDK regiterAppKey:]`
 */
+ (BOOL)initializeWeiboWithAppKey:(NSString *)appKey redirectURI:(NSString *)redirectURI;

///--------------------------------------
/// @name Logging In
///--------------------------------------

/**
 *  @abstract *Asynchronously* logs in a user using Weibo with scopes.
 *
 *  @discussion This method delegates to the Weibo SDK to authenticate the user, and then 
 *  automatically logs in (or creates, in the case where it is a new user) a `MLUser`.
 *  The `didReceiveWeiboResponse:` method defined in `WeiboSDKDelegate` should be implemented and
 *  call `[MLWeiboUtils handleAuthorizeResponse:]` when the delegate receive `WBAuthorizeResponse`.
 *
 *  @param scope The API scopes requested by the app in a list of comma-delimited, case sensitive strings. http://open.weibo.com/wiki/%E6%8E%88%E6%9D%83%E6%9C%BA%E5%88%B6%E8%AF%B4%E6%98%8E#scope
 *  @param block The block to execute when the log in completes. It should have the following signature: `^(MLUser *user, NSError *error)`.
 */
+ (void)loginInBackgroundWithScope:(NSString *)scope block:(MLUserResultBlock)block;

/**
 *  @abstract Handle the weibo authenticate response to complete the login process.
 *
 *  @discussion This method result in a `MLUser` logging in or creating. And then the block in methocd `loginInBackgroundWithScope:block:` will be excuted on main thread.
 *
 *  @param authorizeResponse The authenticate response received by `WeiboSDKDelegate`.
 */
+ (void)handleAuthorizeResponse:(WBAuthorizeResponse *)authorizeResponse;

/**
 *  Logs in a user using weibo. Allows you to handle user login to weibo, then provide authentication data to log in (or create, in the case where it is a new user) the MLUser.
 *
 *  @param token The weibo authentication data.
 *  @param block The block to execute. The block should have the following argument signature: (MLUser *user, NSError *error)
 */
+ (void)loginInBackgroundWithAccessToken:(MLWeiboAccessToken *)token block:(MLUserResultBlock)block;

///--------------------------------------
/// @name Linking Users
///--------------------------------------

/**
 *  @abstract *Asynchronously* links weibo with scopes to an existing `MLUser`.
 *
 *  @discussion This method delegates to the Weibo SDK to authenticate the user, and then automatically links the account to the `MLUser`.
 *  It will also save any unsaved changes that were made to the `user`.
 *
 *  @param user  User to link with weibo.
 *  @param scope The API scopes requested by the app in a list of comma-delimited, case sensitive strings. http://open.weibo.com/wiki/%E6%8E%88%E6%9D%83%E6%9C%BA%E5%88%B6%E8%AF%B4%E6%98%8E#scope
 *  @param block The block to execute when the linking completes. It should have the following signature: `^(BOOL succeeded, NSError *error)`.
 */
+ (void)linkUserInBackground:(MLUser *)user withScope:(NSString *)scope block:(MLBooleanResultBlock)block;

///--------------------------------------
/// @name Linking Users
///--------------------------------------

/**
 *  @abstract *Asynchronously* links Weibo with weibo authentication data to an existing `MLUser`.
 *
 *  @param user  User to link with weibo
 *  @param token The weibo authentication data
 *  @param block The block to execute when the linking completes. It should have the following signature: `^(BOOL succeeded, NSError *error)`.
 */
+ (void)linkUserInBackground:(MLUser *)user withAccessToken:(MLWeiboAccessToken *)token block:(MLBooleanResultBlock)block;

/**
 *  @abstract Unlinks the `MLUser` from a Weibo account *asynchronously*.
 *
 *  @param user  User to unlink from weibo.
 *  @param block The block to execute. It should have the following argument signature: `^(BOOL succeeded, NSError *error)`.
 */
+ (void)unlinkUserInBackground:(MLUser *)user block:(MLBooleanResultBlock)block;

///--------------------------------------
/// @name Getting Linked State
///--------------------------------------

/**
 *  @abstract Whether the user has their account linked to weibo.
 *
 *  @param user User to check for a weibo link. The user must be logged in on this device.
 *
 *  @return `YES` if the user has their account linked to weibo, otherwise `NO`.
 */
+ (BOOL)isLinkedWithUser:(MLUser *)user;

@end

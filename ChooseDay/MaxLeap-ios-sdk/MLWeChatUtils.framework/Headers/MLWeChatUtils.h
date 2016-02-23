//
//  MLWeChatUtils.h
//  MLWeChatUtils
//

#import <MaxLeap/MaxLeap.h>
#import <MLWeChatUtils/MLWeChatAccessToken.h>

@class SendAuthResp;
@protocol WXApiDelegate;

NS_ASSUME_NONNULL_BEGIN

/**
 Provides utility functions for working with Wechat in a MaxLeap application.<br>
 
 This class is currently for iOS only.
 */
@interface MLWeChatUtils : NSObject

///--------------------------------------
/// @name Interacting With WeChat
///--------------------------------------

/*!
 @abstract Initializes MaxLeap WeChat Utils.
 
 @warning You must invoke this in order to use the WeChat functionality in MaxLeap.
 @warning The apis below are only available when `+[WXApi regiterApp:]` successfully.
 
 @param appId       Your wechat app key.
 @param appSecret   Your wechat app secret.
 @param delegate    The WXApi delegate to handle wechat request and response.
 
 @return Return the value returned by `+[WXApi registerApp:]`
 */
+ (BOOL)initializeWeChatWithAppId:(NSString *)appId appSecret:(NSString *)appSecret wxDelegate:(id <WXApiDelegate>)delegate;

///--------------------------------------
/// @name Logging In
///--------------------------------------

/*!
 @abstract *Asynchronously* logs in a user using WeChat with scopes.
 
 @discussion This method delegates to the WeChat SDK to authenticate the user, and then automatically logs in (or creates, in the case where it is a new user) a `MLUser`.
 The `onResp:` method defined in `WXApiDelegate` protocol should be implemented and `[MLWeChatUtils handleAuthorizeResponse:]` should be called when the delegate receive `SendAuthResp`.
 
 @param scope The API scopes requested by the app in a list of comma-delimited, case sensitive strings.
 @param block The block to execute when the log in completes. It should have the following signature: `^(MLUser *user, NSError *error)`.
 */
+ (void)loginInBackgroundWithScope:(nullable NSString *)scope block:(nullable MLUserResultBlock)block;

/*!
 @abstract Handle the wechat authenticate response to complete the login process.
 
 @discussion This method result in a `MLUser` logging in or creating. And then the block in method `loginInBackgroundWithScope:block:` or `linkUserInBackground:withScope:block:` will be excuted on main thread.
 You should call this method when receive the `SendAuthResp` response.
 
 @param authorizeResponse The `SendAuthResp` received in WXApiDelegate method 'onResp:'.
 */
+ (void)handleAuthorizeResponse:(SendAuthResp *)authorizeResponse;

/**
 *  Logs in a user using wechat. Allows you to handle user login to wechat, then provide authentication data to log in (or create, in the case where it is a new user) the `MLUser`.
 *
 *  @param token The wechat authentication data.
 *  @param block The block to execute. The block should have the following argument signature: (MLUser *user, NSError *error)
 */
+ (void)loginInBackgroundWithAccessToken:(MLWeChatAccessToken *)token block:(nullable MLUserResultBlock)block;

///--------------------------------------
/// @name Linking Users
///--------------------------------------

/**
 *  @abstract *Asynchronously* links wechat with scopes to an existing `MLUser`.
 *
 *  @discussion This method delegates to the WeChat SDK to authenticate, and then automatically links the account to the `MLUser`.
 *  It will also save any unsaved changes that were made to the `user`.
 *
 *  @param user  User to link with wechat.
 *  @param scope The API scopes requested by the app in a list of comma-delimited, case sensitive strings.
 *  @param block The block to execute when the linking completes. It should have the following signature: `^(BOOL succeeded, NSError *error)`.
 */
+ (void)linkUserInBackground:(MLUser *)user withScope:(NSString *)scope block:(nullable MLBooleanResultBlock)block;

///--------------------------------------
/// @name Linking Users
///--------------------------------------

/**
 *  @abstract *Asynchronously* links Wechat with authentication data to an existing `MLUser`.
 *
 *  @param user  User to link with wechat
 *  @param token The wechat authentication data
 *  @param block The block to execute when the linking completes. It should have the following signature: `^(BOOL succeeded, NSError *error)`.
 */
+ (void)linkUserInBackground:(MLUser *)user withAccessToken:(MLWeChatAccessToken *)token block:(nullable MLBooleanResultBlock)block;

/*!
 @abstract Unlinks the `MLUser` from a Wechat account *asynchronously*.
 
 @param user  User to unlink from Wechat.
 @param block The block to execute. It should have the following argument signature: `^(BOOL succeeded, NSError *error)`.
 */
+ (void)unlinkUserInBackground:(MLUser *)user block:(nullable MLBooleanResultBlock)block;

///--------------------------------------
/// @name Getting Linked State
///--------------------------------------

/*!
 @abstract Whether the user has their account linked to wechat.
 
 @param user User to check for a wechat link. The user must be logged in on this device.
 
 @returns `YES` if the user has their account linked to wechat, otherwise `NO`.
 */
+ (BOOL)isLinkedWithUser:(nullable MLUser *)user;

@end

NS_ASSUME_NONNULL_END

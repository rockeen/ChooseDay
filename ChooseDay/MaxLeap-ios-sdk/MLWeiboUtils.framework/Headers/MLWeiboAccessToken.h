//
//  MLWeiboAccessToken.h
//  MLWeiboUtils
//

#import <Foundation/Foundation.h>
#import <MaxLeap/MLConstants.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 @class MLWeiboAccessToken
 @abstract Represents an immutable access token for using Weibo services.
 */
@interface MLWeiboAccessToken : NSObject

/*!
 @abstract Returns the user ID.
 */
@property (readonly, nonatomic, strong) NSString *userID;

/*!
 @abstract Returns the weibo access token.
 */
@property (readonly, nonatomic, strong) NSString *tokenString;

/*!
 @abstract Returns the expiration date.
 */
@property (readonly, nonatomic, strong, nullable) NSDate *expirationDate;

/*!
 @abstract Returns the refresh token.
 */
@property (readonly, nonatomic, strong, nullable) NSString *refreshToken;

/*!
 @abstract Initializes a new instance.
 @param tokenString     The opaque token string.
 @param userID          The user Id.
 @param expirationDate  The optional expiration date (defaults to distantFuture).
 @param refreshToken    The refresh token
 */
- (instancetype)initWithTokenString:(NSString *)tokenString
                             userID:(NSString *)userID
                     expirationDate:(nullable NSDate *)expirationDate
                       refreshToken:(nullable NSString *)refreshToken
NS_DESIGNATED_INITIALIZER;

/*!
 @abstract Returns the "global" weibo access token that represents the currently logged in weibo user.
 */
+ (nullable MLWeiboAccessToken *)currentAccessToken;

/*!
 @abstract Call +[WBHttpRequest requestForRenewAccessTokenWithRefreshToken:queue:withCompletionHandler:] to renew current weibo access token and save the new token to the MaxLeap servers.
 @param completionHandler an optional callback handler that can surface any errors related to access token refreshing.
 @discussion On a successful refresh, the currentAccessToken will be updated so you typically only need to
 observe the `MLWeiboAccessTokenDidChangeNotification` notification.
 */
+ (void)refreshCurrentAccessToken:(nullable MLBooleanResultBlock)completionHandler;

@end


/*!
 @abstract Notification indicating that the `currentAccessToken` has changed.
 @discussion the userInfo dictionary of the notification will contain keys
 `kMLWeiboOldAccessTokenKey` and
 `kMLWeiboNewAccessTokenKey`.
 */
FOUNDATION_EXPORT NSString * const MLWeiboAccessTokenDidChangeNotification;

/*!
 @abstract A key in the notification's userInfo that will be set
 if and only if the user ID changed between the old and new tokens.
 @discussion Token refreshes can occur automatically with the SDK
 which do not change the user. If you're only interested in user
 changes (such as logging out), you should check for the existence
 of this key. The value is a NSNumber with a boolValue.
 */
FOUNDATION_EXPORT NSString * const kMLWeiboUserIdChangedKey;

/*
 @abstract key in notification's userInfo object for getting the old token.
 @discussion If there was no old token, the key will not be present.
 */
FOUNDATION_EXPORT NSString * const kMLWeiboOldAccessTokenKey;

/*
 @abstract key in notification's userInfo object for getting the new token.
 @discussion If there is no new token, the key will not be present.
 */
FOUNDATION_EXPORT NSString * const kMLWeiboNewAccessTokenKey;


NS_ASSUME_NONNULL_END

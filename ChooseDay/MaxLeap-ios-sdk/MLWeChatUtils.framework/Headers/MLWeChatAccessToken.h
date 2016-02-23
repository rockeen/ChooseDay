//
//  MLWeChatAccessToken.h
//  MLWeChatUtils
//

#import <MaxLeap/MaxLeap.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 @class MLWeChatAccessToken
 @abstract Represents an immutable access token for using WeChat services.
 */
@interface MLWeChatAccessToken : NSObject

/*!
 @abstract Returns the wechat user ID.
 */
@property (readonly, nonatomic, copy) NSString *userID;

/*!
 @abstract Returns the wechat access token.
 */
@property (readonly, nonatomic, copy) NSString *tokenString;

/*!
 @abstract Returns the expiration date.
 */
@property (readonly, nonatomic, copy, nullable) NSDate *expirationDate;

/*!
 @abstract Returns the refresh token.
 */
@property (readonly, nonatomic, copy, nullable) NSString *refreshToken;

/*!
 @abstract Returns the scope.
 */
@property (readonly, nonatomic, copy, nullable) NSString *scope;

/**
 *  @abstract Initializes a new instance.
 *
 *  @param tokenString    The opaque token string.
 *  @param userID         The wechat user id
 *  @param expirationDate The optional expiration date (defaults to distantFuture).
 *  @param refreshToken   The refresh token
 *  @param scope          The API scopes requested by the app in a list of comma-delimited, case sensitive strings.
 *
 *  @return An instance of `MLWeChatAccessToken`.
 */
- (instancetype)initWithTokenString:(NSString *)tokenString
                             userID:(NSString *)userID
                     expirationDate:(nullable NSDate *)expirationDate
                       refreshToken:(nullable NSString *)refreshToken
                              scope:(nullable NSString *)scope
NS_DESIGNATED_INITIALIZER;

/*!
 @abstract Returns the "global" wechat access token that represents the currently logged in user.
 */
+ (nullable MLWeChatAccessToken *)currentAccessToken;

/*!
 @abstract Renew current wechat access token using refresh.
 
 @discussion On a successful refresh, the currentAccessToken will be updated so you typically only need to observe the `MLWeChatAccessTokenDidChangeNotification` notification.
 
 @param completionHandler An optional callback handler that can surface any errors related to access token refreshing.
 */
+ (void)refreshCurrentAccessToken:(nullable MLBooleanResultBlock)completionHandler;

@end


/*!
 @abstract Notification indicating that the `currentAccessToken` has changed.
 @discussion the userInfo dictionary of the notification will contain keys
 `kMLWeChatOldAccessTokenKey` and
 `kMLWeChatNewAccessTokenKey`.
 */
FOUNDATION_EXPORT NSString * const MLWeChatAccessTokenDidChangeNotification;

/*!
 @abstract A key in the notification's userInfo that will be set
 if and only if the user ID changed between the old and new tokens.
 @discussion Token refreshes can occur automatically with the SDK
 which do not change the user. If you're only interested in user
 changes (such as logging out), you should check for the existence
 of this key. The value is a NSNumber with a boolValue.
 */
FOUNDATION_EXPORT NSString * const kMLWeChatUserIdChangedKey;

/*
 @abstract key in notification's userInfo object for getting the old token.
 @discussion If there was no old token, the key will not be present.
 */
FOUNDATION_EXPORT NSString * const kMLWeChatOldAccessTokenKey;

/*
 @abstract key in notification's userInfo object for getting the new token.
 @discussion If there is no new token, the key will not be present.
 */
FOUNDATION_EXPORT NSString * const kMLWeChatNewAccessTokenKey;

NS_ASSUME_NONNULL_END


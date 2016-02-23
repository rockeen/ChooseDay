//
//  MLTwitterUtils.h
//  MaxLeap
//

#import <MaxLeap/MaxLeap.h>
#import <MLTwitterUtils/ML_Twitter.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 Provides utility functions for working with Twitter in a MaxLeap application.
 
 This class is currently for iOS only.
 */
@interface MLTwitterUtils : NSObject


/** @name Interacting With Twitter */

/*!
 Gets the instance of the Twitter object that MaxLeap uses.
 @return The Twitter instance.
 */
+ (nullable ML_Twitter *)twitter;

/*!
 Initializes the Twitter singleton. You must invoke this in order to use the Twitter functionality in MaxLeap.
 
 @param consumerKey     Your Twitter application's consumer key.
 @param consumerSecret  Your Twitter application's consumer secret.
 */
+ (void)initializeWithConsumerKey:(NSString *)consumerKey
                   consumerSecret:(NSString *)consumerSecret;

/*!
 Whether the user has their account linked to Twitter.
 
 @param user User to check for a Twitter link. The user must be logged in on this device.
 
 @return True if the user has their account linked to Twitter.
 */
+ (BOOL)isLinkedWithUser:(nullable MLUser *)user;

/** @name Logging In & Creating Twitter-Linked Users */

/*!
 Logs in a user using Twitter. This method delegates to Twitter to authenticate the user, and then automatically logs in (or creates, in the case where it is a new user) a MLUser.
 
 @param block The block to execute. The block should have the following argument signature: (MLUser *user, NSError *error)
 */
+ (void)logInWithBlock:(nullable MLUserResultBlock)block;

/*!
 Logs in a user using Twitter. Allows you to handle user login to Twitter, then provide authentication data to log in (or create, in the case where it is a new user) the MLUser.
 
 @param twitterId       The id of the Twitter user being linked
 @param screenName      The screen name of the Twitter user being linked
 @param authToken       The auth token for the user's session
 @param authTokenSecret The auth token secret for the user's session
 @param block           The block to execute. The block should have the following argument signature: (MLUser *user, NSError *error)
 */
+ (void)logInWithTwitterId:(NSString *)twitterId
                screenName:(NSString *)screenName
                 authToken:(NSString *)authToken
           authTokenSecret:(NSString *)authTokenSecret
                     block:(nullable MLUserResultBlock)block;

/** @name Linking Users with Twitter */

/*!
 Links Twitter to an existing MLUser. This method delegates to Twitter to authenticate the user, and then automatically links the account to the MLUser.
 
 @param user    User to link to Twitter.
 @param block   The block to execute. The block should have the following argument signature: (BOOL *success, NSError *error)
 */
+ (void)linkUser:(MLUser *)user block:(nullable MLBooleanResultBlock)block;

/*!
 Links Twitter to an existing MLUser. Allows you to handle user login to Twitter, then provide authentication data to link the account to the MLUser.
 
 @param user            User to link to Twitter.
 @param twitterId       The id of the Twitter user being linked
 @param screenName      The screen name of the Twitter user being linked
 @param authToken       The auth token for the user's session
 @param authTokenSecret The auth token secret for the user's session
 @param block           The block to execute. The block should have the following argument signature: (BOOL *success, NSError *error)
 */
+ (void)linkUser:(MLUser *)user
       twitterId:(NSString *)twitterId
      screenName:(NSString *)screenName
       authToken:(NSString *)authToken
 authTokenSecret:(NSString *)authTokenSecret
           block:(nullable MLBooleanResultBlock)block;

/** @name Unlinking Users from Twitter */

/*!
 Makes an asynchronous request to unlink a user from a Twitter account.
 
 @param user    User to unlink from Twitter.
 @param block   The block to execute. The block should have the following argument signature: (BOOL succeeded, NSError *error)
 */
+ (void)unlinkUserInBackground:(MLUser *)user
                         block:(nullable MLBooleanResultBlock)block;


@end

NS_ASSUME_NONNULL_END

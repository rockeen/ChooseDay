//
//  MLHelpCenter.h
//  MLHelpCenter
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  The result types of asking user to rate app.
 */
typedef NS_ENUM(NSInteger, HCAppRateAlertAction){
    
    /** User cancelled the app rate request. */
    HCAppRateAlertCancel = 0,
    
    /** User Choose the option to send feedback. */
    HCAppRateAlertFeedback,
    
    /** User choose the option to rate app and sdk display app review page successfully. */
    HCAppRateAlertSuccess,
    
    /** User choose the option to rate app but sdk failed to display app review page. */
    HCAppRateAlertFail
};

/**
 * This document describes the API exposed by the MLHelpCenter SDK (1.x) which the developers can use to integrate HelpCenter support into their iOS applications. If you want documentation regarding how to use the various features provided by the MLHelpCenter SDK, please visit the [developer docs](https://leap.as/docs/overview.html)
 */
@interface MLHelpCenter : NSObject <UIAlertViewDelegate>

/**
 *  Initialize HelpCenter module, starting check new message.
 */
+ (void)install;

/** 
 *  To show an alert view on app enter foreground if there were new messages. Default is YES.
 *
 * @param yesOrNo A boolean value to enable or disable the new message alert
 */
+ (void)alertNewMessage:(BOOL)yesOrNo;

/** Returns an instance of HelpCenter
 *
 * When calling any HelpCenter instance method you must use sharedInstance. For example to call showFAQs: you must call it like [[MLHelpCenter sharedInstance] showFAQs:self];
 */
+ (MLHelpCenter *)sharedInstance;

/** Show the HelpCenter conversation screen (with Optional Arguments)
 *
 * To show the HelpCenter conversation screen with optional arguments you will need to pass the name of the viewcontroller on which the conversation screen will show up and an options dictionary. If you do not want to pass any options then just pass nil which will take on the default options.
 *
 * @param viewController viewController on which the HelpCenter report issue screen will show up.
 */
- (void)showConversation:(UIViewController *)viewController;

/** Show the support screen with only the faqs (with Optional Arguments)
 *
 * To show the HelpCenter screen with only the faq sections with search with optional arguments, you can use this api. If you do not want to pass any options then just pass nil which will take on the default options.
 *
 * @param viewController viewController on which the HelpCenter faqs screen will show up.
 */
- (void)showFAQs:(UIViewController *)viewController;

/** Show the HelpCenter screen with faqs from a particular section
 *
 * To show the HelpCenter screen for showing a particular faq section you need to pass the publish-id of the faq section and the name of the viewcontroller on which the faq section screen will show up. For example from inside a viewcontroller you can call the HelpCenter faq section screen by passing the argument “self” for the viewController parameter. If you do not want to pass any options then just pass nil which will take on the default options.
 *
 * @param faqSectionPublishID   the publish id associated with the faq section which is shown in the FAQ page on the admin side (__yourcompanyname__.leap.as/admin/faq/).
 * @param viewController        viewController on which the helpcenter faq section screen will show up.
 */
- (void)showFAQSection:(NSString *)faqSectionPublishID withController:(UIViewController *)viewController;

/** Show the HelpCenter screen with a single faq
 *
 * To show the HelpCenter screen for showing a single faq you need to pass the publish-id of the faq and the name of the viewcontroller on which the faq screen will show up. For example from inside a viewcontroller you can call the HelpCenter faq section screen by passing the argument “self” for the viewController parameter. If you do not want to pass any options then just pass nil which will take on the default options.
 *
 * @param faqPublishID      the publish id associated with the faq which is shown when you expand a single FAQ (__yourcompanyname__.leap.as.com/admin/faq/)
 * @param viewController    viewController on which the HelpCenter faq section screen will show up.
 */
- (void) showSingleFAQ:(NSString *)faqPublishID withController:(UIViewController *)viewController;

/** Get the new message count for replies to new conversations.
 *
 *  If you want to show your user notifications for replies on any ongoing conversation, you can get the notification count asynchronously by using this method. You can get result from the block.
 *
 *  @param block The block with the result will be excute on main thread. It should have following signatures: (NSInteger count).
 */
- (void)getNewMessageCountInBackgroundWithBlock:(nullable void(^)(NSInteger count))block;

/** Show an alert to request app rating
 *
 *  To manually show an alert for app rating, you need automated reviews disabled in admin.
 *  Also, if there is an ongoing conversation, the review alert will not show up.
 *
 *  @param completionBlock The block gives result of app rating request. It should have folowing signature: (HCAppRateAlertAction result)
 */
+ (void) showAlertToRateAppWithCompletionBlock:(nullable void (^)(HCAppRateAlertAction))completionBlock;

@end

NS_ASSUME_NONNULL_END


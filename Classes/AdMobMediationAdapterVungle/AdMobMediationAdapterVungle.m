//
//  AdMobMediationAdapterVungle.m
//
//  Created by William Locke on 3/5/13.
//
//

#import "AdMobMediationAdapterVungle.h"
#import "GADBannerView.h"
#import "GADCustomEventInterstitial.h"
#import <VungleSDK/VungleSDK.h>

@interface AdMobMediationAdapterVungle()<VungleSDKDelegate>{
    
}
@end

@implementation AdMobMediationAdapterVungle

@synthesize delegate;

// Will be set by the AdMob SDK.


-(UIViewController *)applicationsCurrentRootViewController{
    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    while ([rootViewController isKindOfClass:[UITabBarController class]] || [rootViewController isKindOfClass:[UINavigationController class]]) {
        if ([rootViewController isKindOfClass:[UITabBarController class]]){
            rootViewController = ((UITabBarController *)rootViewController).selectedViewController;
        }else if ([rootViewController isKindOfClass:[UINavigationController class]]){
            rootViewController = ((UINavigationController *)rootViewController).topViewController;
        }
    }
    
    return rootViewController;
}

+(instancetype)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}

#pragma mark -
#pragma mark GADCustomEventInterstitial

- (void)requestInterstitialAdWithParameter:(NSString *)serverParameter
                                     label:(NSString *)serverLabel
                                   request:(GADCustomEventRequest *)customEventRequest {
    

    [[VungleSDK sharedSDK] setDelegate:self];
    
    UIViewController *rootViewController = [self applicationsCurrentRootViewController];

    [[VungleSDK sharedSDK] setLoggingEnabled:YES];
    
//    [self.delegate customEventInterstitialWillPresent:self];
//    [self.delegate customEventInterstitial:self didReceiveAd:nil];
//    [[VungleSDK sharedSDK] playAd:rootViewController];
    
    
    if ([[VungleSDK sharedSDK] isCachedAdAvailable]) {
        [self.delegate customEventInterstitialWillPresent:self];
        [self.delegate customEventInterstitial:self didReceiveAd:nil];
        [[VungleSDK sharedSDK] playAd:rootViewController];
    }else{
        [self.delegate customEventInterstitial:self didFailAd:nil];
    }

    

}

- (void)presentFromRootViewController:(UIViewController *)rootViewController {
    NSLog(@"present");
    
}


#pragma mark vungle delegate methods
/**
 * if implemented, this will get called when the SDK is about to show an ad. This point
 * might be a good time to pause your game, and turn off any sound you might be playing.
 */
- (void)vungleSDKwillShowAd{
    
}

/**
 * if implemented, this will get called when the SDK closes the ad view, but there might be
 * a product sheet that will be presented. This point might be a good place to resume your game
 * if there's no product sheet being presented. The viewInfo dictionary will contain the
 * following keys:
 * - "completedView": NSNumber representing a BOOL whether or not the video can be considered a
 *               full view.
 * - "playTime": NSNumber representing the time in seconds that the user watched the video.
 * - "didDownlaod": NSNumber representing a BOOL whether or not the user clicked the download
 *                  button.
 */
- (void)vungleSDKwillCloseAdWithViewInfo:(NSDictionary*)viewInfo willPresentProductSheet:(BOOL)willPresentProductSheet{
    [self.delegate customEventInterstitialDidDismiss:self];
}

/**
 * if implemented, this will get called when the product sheet is about to be closed.
 */
- (void)vungleSDKwillCloseProductSheet:(id)productSheet{
    
}

/**
 * if implemented, this will get called when there is an ad cached and ready to be shown.
 */
- (void)vungleSDKhasCachedAdAvailable{
    
}


@end

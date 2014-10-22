//
//  AdMobMediationAdapterVungle.m
//
//  Created by William Locke on 3/5/13.
//
//

#import "AdMobMediationAdapterVungle.h"
#import "GADBannerView.h"
#import "NFChartboost.h"
#import "GADCustomEventInterstitial.h"
#import "VGVunglePub.h"

@interface AdMobMediationAdapterVungle()<VGVunglePubDelegate>{
    
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
    
    [VGVunglePub setDelegate:self];
    
    if ([VGVunglePub adIsAvailable]) {
        [self.delegate customEventInterstitial:self didReceiveAd:nil];
        [self.delegate customEventInterstitialWillPresent:self];
        UIViewController *rootViewController = [self applicationsCurrentRootViewController];
        [VGVunglePub playIncentivizedAd:rootViewController animated:YES showClose:YES userTag:nil];
        
    }else{
        [self.delegate customEventInterstitial:self didFailAd:nil];
    }
    
    NSLog(@"test vungle");

}

- (void)presentFromRootViewController:(UIViewController *)rootViewController {
    NSLog(@"present");
    //[interstitial_ presentFromRootViewController:rootViewController];
    
}


#pragma mark DVAdKitDelegate
#pragma mark vungle delegate methods
static BOOL finished_last_vungle_video_ = NO;

- (void)vungleMoviePlayed:(VGPlayData*)playData
{
    NSLog(@"vungleMoviePlayed: %@", playData);
    if ([playData playedFull]) {
        finished_last_vungle_video_ = YES;
    }
}

- (void)vungleStatusUpdate:(VGStatusData*)statusData
{
    NSLog(@"vungleStatusUpdate: %@", statusData);
}

- (void)vungleViewDidDisappear:(UIViewController*)viewController
{
    NSLog(@"vungleViewDidDisappear");
    if (finished_last_vungle_video_) {
        NSLog(@"vungle award coins!!!!");
        finished_last_vungle_video_ = NO;
    }
    [self.delegate customEventInterstitialDidDismiss:self];
}

- (void)vungleViewDidDisappear:(UIViewController*)viewController willShowProductView:(BOOL)willShow
{
    NSLog(@"vungleViewDidDisappear:willShowProductView:");
    NSLog(@"vungleViewDidDisappear");
    if (finished_last_vungle_video_) {
        NSLog(@"vungle award coins!!!!");
        finished_last_vungle_video_ = NO;
    }
    [self.delegate customEventInterstitialDidDismiss:self];
}

- (void)vungleViewWillAppear:(UIViewController*)viewController
{
    NSLog(@"vungleViewWillAppear");
}

- (void)vungleAppStoreWillAppear
{
    NSLog(@"vungleAppStoreWillAppear");
    [self.delegate customEventInterstitialWillLeaveApplication:self];
}

- (void)vungleAppStoreViewDidDisappear
{
    NSLog(@"vungleAppStoreViewDidDisappear");
    [self.delegate customEventInterstitialDidDismiss:self];
}
@end

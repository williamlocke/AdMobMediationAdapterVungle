//
//  AdMobMediationAdapterChartboost.m
//
//  Created by William Locke on 3/5/13.
//
//

#import "AdMobMediationAdapterChartboost.h"
#import "GADBannerView.h"
#import "NFChartboost.h"
#import "GADCustomEventInterstitial.h"



@interface AdMobMediationAdapterChartboost(){
    
}
@end

@implementation AdMobMediationAdapterChartboost

@synthesize delegate;

// Will be set by the AdMob SDK.



#pragma mark -
#pragma mark GADCustomEventInterstitial

- (void)requestInterstitialAdWithParameter:(NSString *)serverParameter
                                     label:(NSString *)serverLabel
                                   request:(GADCustomEventRequest *)customEventRequest {
    
    [[NFChartboost sharedInstance] setDelegate:(id<NFAdDisplayerDelegate>) self];
    
    [[NFChartboost sharedInstance] showInterstitial:serverLabel completionHandler:^(BOOL impressionWasFilled) {

        if (impressionWasFilled) {
            [self.delegate customEventInterstitialWillPresent:self];
            [self.delegate customEventInterstitial:self didReceiveAd:nil];
        }else{
            [self.delegate customEventInterstitial:self didFailAd:nil];
        }
    }];
    
    NSLog(@"test");

}

- (void)presentFromRootViewController:(UIViewController *)rootViewController {
    NSLog(@"present");
    //[interstitial_ presentFromRootViewController:rootViewController];
    
}


#pragma mark DVAdKitDelegate
-(void)didClickInterstitial:(NSString *)location{
    [self.delegate customEventInterstitialWillLeaveApplication:self];
    [self.delegate customEventInterstitialDidDismiss:self];
}

-(void)didCloseInterstitial:(NSString *)location{
    [self.delegate customEventInterstitialDidDismiss:self];
}

@end

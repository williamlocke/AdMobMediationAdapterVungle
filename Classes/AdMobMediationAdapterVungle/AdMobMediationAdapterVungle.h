//
//  AdMobMediationAdapterVungle.h
//
//  Created by William Locke on 3/5/13.
//
//

#import <Foundation/Foundation.h>
#import "NFAdDisplayer.h"
#import "GADInterstitial.h"
#import "GADInterstitialDelegate.h"
#import "GADCustomEventInterstitial.h"

@class AdMobMediationAdapterVungle;



@interface AdMobMediationAdapterVungle : NSObject<GADCustomEventInterstitial>


+(instancetype)sharedInstance;

- (void)requestInterstitialAdWithParameter:(NSString *)serverParameter
                                     label:(NSString *)serverLabel
                                   request:(GADCustomEventRequest *)customEventRequest;

//@property (nonatomic, strong) id delegate;

@end

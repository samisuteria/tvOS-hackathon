//
//  DigitsKit.h
//  DigitsKit
//
//  Copyright (c) 2015 Twitter Inc. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if __has_feature(modules)
@import TwitterCore;
#else
#import <TwitterCore/TwitterCore.h>
#endif

#import <DigitsKit/DGTAssistedAuthViewController.h>
#import <DigitsKit/DGTAppearance.h>
#import <DigitsKit/DGTErrors.h>
#import <DigitsKit/DGTOAuthSigning.h>
#import <DigitsKit/DGTSession.h>
#import <DigitsKit/DGTSessionUpdateDelegate.h>
#import <DigitsKit/Digits.h>

/**
 *  `DigitsKit` can be used as an element in the array passed to the `+[Fabric with:]`.
 */
#define DigitsKit [Digits sharedInstance]

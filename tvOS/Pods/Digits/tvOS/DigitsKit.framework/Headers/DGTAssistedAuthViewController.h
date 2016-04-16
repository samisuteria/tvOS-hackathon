//
//  DGTAssistedAuthViewController.h
//  DigitsKit
//
//  Copyright © 2015 Twitter Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DigitsKit/DGTSession.h>

@class DGTAppearance;

NS_ASSUME_NONNULL_BEGIN

/**
 *  The `DGTAssistedAuthViewController` class is used to perform the Digits-for-devices authentication flow on Apple TV. This lets your customers sign in with Digits -  no TV text-input required.
 *  When you present the view controller, it will show the customer a code that they can enter on https://digits.com. Then, you'll get access to the DGTSession object just like on iOS.
 */
@interface DGTAssistedAuthViewController : UIViewController

/**
  *  Returns an instance of DGTAssistedAuthViewController, themed according to the given style. 
  *  Note that instances should be used once. Create another DGTAssistedAuthViewController to perform the process again.
  *
  *  @param appearance        Appearance of the view. Pass `nil` to use the default appearance.
  *  @param completionBlock   Block called after the authentication flow has ended. Will be set to nil once called.
  */
- (instancetype)initWithAppearance:(nullable DGTAppearance *)appearance completionBlock:(DGTAuthenticationCompletion)completionBlock;

- (instancetype)init __unavailable;
- (instancetype)initWithCoder:(NSCoder *)aDecoder __unavailable;
- (instancetype)initWithNibName:(nullable  NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil __unavailable;

@end

NS_ASSUME_NONNULL_END

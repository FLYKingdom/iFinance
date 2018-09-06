//
//  MyBaseViewController.m
//  schoolIM
//
//  Created by bingo on 14-10-15.
//  Copyright (c) 2014年 profusionup. All rights reserved.
//

#import "BaseViewController.h"

#import "TOPasscodeViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface BaseViewController ()<TOPasscodeViewControllerDelegate>

@property (nonatomic, copy) NSString *pageEvent;

@property (nonatomic, strong) LAContext *authContext;

@end

@implementation BaseViewController

-(LAContext *)authContext{
    if (!_authContext) {
        _authContext = [[LAContext alloc] init];
    }
    return _authContext;
}

-(void)setupNavigationTitle:(NSString *)titleStr{
    UILabel *label= [[UILabel alloc] init];
    [label setText:titleStr];
    [label setTextColor:[UIColor redColor]];
    [label setFont:[UIFont systemFontOfSize:17]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label sizeToFit];
    self.navigationItem.titleView = label;
    
    self.pageEvent = titleStr;//设置 evnet
}

- (void)showPasscodeView {
    TOPasscodeViewController *passcodeViewController = [[TOPasscodeViewController alloc] initWithStyle:TOPasscodeViewStyleTranslucentDark passcodeType:TOPasscodeTypeSixDigits];
    passcodeViewController.delegate = self;
    passcodeViewController.rightAccessoryButton = [UIButton new];
    BOOL biometricsAvailable = [self.authContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil];
    passcodeViewController.allowBiometricValidation = biometricsAvailable;
    
    BOOL faceIDAvailable = NO;
    if (@available(iOS 11.0, *)) {
        faceIDAvailable = NO;//(self.authContext.biometryType == LABiometryTypeFaceID);
    }
    
    [self presentViewController:passcodeViewController animated:YES completion:nil];
}

#pragma mark - passcode delegate

- (void)didTapCancelInPasscodeViewController:(TOPasscodeViewController *)passcodeViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)passcodeViewController:(TOPasscodeViewController *)passcodeViewController isCorrectCode:(NSString *)code
{
    return [code isEqualToString:@"111111"];
}

- (void)didPerformBiometricValidationRequestInPasscodeViewController:(TOPasscodeViewController *)passcodeViewController
{
    __weak typeof(self) weakSelf = self;
    NSString *reason = @"使用TouchID，解锁Finance";
    id reply = ^(BOOL success, NSError *error) {
        
        // Touch ID validation was successful
        // (Use this to dismiss the passcode controller and display the protected content)
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // Create a new Touch ID context for next time
                [weakSelf.authContext invalidate];
                weakSelf.authContext = [[LAContext alloc] init];
                
                // Dismiss the passcode controller
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            });
            return;
        }
        
        // Actual UI changes need to be made on the main queue
        dispatch_async(dispatch_get_main_queue(), ^{
            [passcodeViewController setContentHidden:NO animated:YES];
        });
        
        // The user hit 'Enter Password'. This should probably do nothing
        // but make sure the passcode controller is visible.
        if (error.code == kLAErrorUserFallback) {
            NSLog(@"User tapped 'Enter Password'");
            return;
        }
        
        // The user hit the 'Cancel' button in the Touch ID dialog.
        // At this point, you could either simply return the user to the passcode controller,
        // or dismiss the protected content and go back to a safer point in your app (Like the login page).
        if (error.code == LAErrorUserCancel) {
            NSLog(@"User tapped cancel.");
            return;
        }
        
        // There shouldn't be any other potential errors, but just in case
        NSLog(@"%@", error.localizedDescription);
    };
    
    [passcodeViewController setContentHidden:YES animated:YES];
    
    [self.authContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:reply];
}


@end

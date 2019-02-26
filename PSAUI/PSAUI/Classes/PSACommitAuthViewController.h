//
//  PSACommitAuthViewController.h
//  PSA
//
//  Created by Pivulski, Nikolai on 05.07.2018.
//

#import <UIKit/UIKit.h>
#import <PSACommon/PSACommon.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PSACommitAuthViewControllerDelegate;

@interface PSACommitAuthViewController : UIViewController

+ (instancetype)controllerWithTheme:(nullable PSATheme *)theme
                           delegate:(id<PSACommitAuthViewControllerDelegate>)delegate;

@end

@protocol PSACommitAuthViewControllerDelegate <NSObject>
- (void)commitAuthViewControllerCancelled:(PSACommitAuthViewController *)controller;
- (void)commitAuthViewControllerConfirmed:(PSACommitAuthViewController *)controller;
@end

NS_ASSUME_NONNULL_END

//
//  PinViewController.h
//  PSA
//
//  Created by Sadovsky, Aleksandr on 8/28/18.
//

#import <UIKit/UIKit.h>
#import <PSACommon/PSACommon.h>

@protocol PSAPinViewControllerDelegate <NSObject>
- (void)authComplete:(NSString *)pin;
- (void)authCancel;
@end

@interface PSAPinViewController : UIViewController

+ (instancetype)controllerWithTheme:(nullable PSATheme *)theme
                           delegate:(id<PSAPinViewControllerDelegate>)delegate;

@end

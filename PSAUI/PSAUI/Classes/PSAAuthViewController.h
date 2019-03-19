//
//  PSAAuthViewController.h
//  PSA
//
//  Created by Pivulski, Nikolai on 25.06.2018.
//

#import <UIKit/UIKit.h>
#import <PSACommon/PSACommon.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSAAuthViewController : UIViewController

+ (instancetype)controllerWithTheme:(nullable PSATheme *)theme
                          sessionId:(nullable NSNumber *)sessionId
                         completion:(void (^)(BOOL, PSASharedStatuses))completion;

@end

NS_ASSUME_NONNULL_END

//
//  PSAEnrollmentViewController.h
//  PSAUI
//
//  Created by Pivulski, Nikolai on 12/06/2018.
//

#import <UIKit/UIKit.h>
#import "PSACommon/PSASharedStatuses.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSAEnrollmentViewController : UIViewController

+ (instancetype)controllerWithCompletion:(void (^)(PSASharedStatuses))completion;

@end

NS_ASSUME_NONNULL_END

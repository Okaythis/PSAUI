//
//  PSAEnrollmentViewController.h
//  PSA
//
//  Created by Pivulski, Nikolai on 12/06/2018.
//

#import <UIKit/UIKit.h>
#import "PSACommon/PSASharedStatuses.h"
#import "PSACommon/PSACommon.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PSAEnrollmentControllerDelegate
- (void)viewWillAppearWith:(id<PSABaseClientActionControllerDelegate>)delegate;
@end

@interface PSAEnrollmentViewController : UIViewController

+ (instancetype)controllerWithCompletion:(void (^)(PSASharedStatuses))completion
                                delegate:(id<PSAEnrollmentControllerDelegate>) delegate;

@end

NS_ASSUME_NONNULL_END

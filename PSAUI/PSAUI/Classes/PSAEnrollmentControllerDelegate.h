//
//  PSAAuthController.h
//  PSA
//
//  Created by Pivulski, Nikolai on 26.06.2018.
//

#import <Foundation/Foundation.h>
#import <PSACommon/PSACommon.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PSAEnrollmentControllerDelegate <PSABaseClientActionControllerDelegate>
- (void)authControllerFinishedAuthPrepare:(PSABaseClientActionController *)controller;
@end

NS_ASSUME_NONNULL_END

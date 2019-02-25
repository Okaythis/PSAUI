//
//  PSAAuthInfo.h
//  PSA
//
//  Created by Sadovsky, Aleksandr on 8/24/18.
//

#import <UIKit/UIKit.h>
#import <PSACommon/PSACommon.h>
#import "PSAXIBControl.h"

@protocol AuthInfoDelegate
- (void)confirmed;
- (void)cancelled;
@end

@interface PSAAuthInfo : PSAXIBControl
@property (strong, nullable) id<AuthInfoDelegate> delegate;

- (void)setupWithTheme:(nullable PSATheme *)theme;
@end

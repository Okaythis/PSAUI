//
//  PSAKeyboard.h
//  PSA
//
//  Created by Sadovsky, Aleksandr on 8/27/18.
//

#import <UIKit/UIKit.h>
#import <PSACommon/PSACommon.h>
#import "PSAXIBControl.h"

@protocol PSAKeyboardDelegate
- (void)valueButtonPressed:(nonnull NSString *)key;
@end

@interface PSAKeyboard : PSAXIBControl
@property (strong, nullable) id<PSAKeyboardDelegate> delegate;

- (void)setupWithTheme:(nullable PSATheme *)theme;
@end

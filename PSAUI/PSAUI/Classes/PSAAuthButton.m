//
//  PSAAuthButton.m
//  PSAUI
//
//  Created by Pivulski, Nikolai on 07.07.2018.
//

#import "PSAAuthButton.h"

@implementation PSAAuthButton

- (nullable instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
    }
    return self;
}

@end

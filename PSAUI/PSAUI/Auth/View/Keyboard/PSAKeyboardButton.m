//
//  PSAKeyboardButton.m
//  PSA
//
//  Created by Sadovsky, Aleksandr on 8/27/18.
//

#import "PSAKeyboardButton.h"

@implementation PSAKeyboardButton

- (nullable instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.layer.masksToBounds = NO;
        self.layer.shadowColor = UIColor.blackColor.CGColor;
        self.layer.shadowOffset = CGSizeMake(1.0, 2.0);
        self.layer.shadowRadius = 2.0;
        self.layer.shadowOpacity = 0.3;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = self.bounds.size.width / 2.0;
}

@end

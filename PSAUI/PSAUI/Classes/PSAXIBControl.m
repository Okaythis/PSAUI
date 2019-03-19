//
//  PSAXIBControl.m
//  PSAUI
//
//  Created by Sadovsky, Aleksandr on 8/29/18.
//

#import "PSAXIBControl.h"

@implementation PSAXIBControl

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self defaultInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultInit];
    }
    return self;
}

#pragma mark - Abstract

- (UIView *)fetchContentView {
    return nil;
}

#pragma mark - Private

- (void)defaultInit {
    [[NSBundle bundleForClass:self.class] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    UIView *contentView = [self fetchContentView];
    if (contentView != nil) {
        [self addSubview:contentView];
        contentView.frame = self.bounds;
    }
}

@end

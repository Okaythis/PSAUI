//
//  PSAAuthInfo.m
//  PSA
//
//  Created by Sadovsky, Aleksandr on 8/24/18.
//

#import <AVFoundation/AVFoundation.h>
#import "PSAAuthInfo.h"

@interface PSAAuthInfo()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *fromTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@end

@implementation PSAAuthInfo

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 10;
        self.contentView.layer.masksToBounds = NO;
        self.contentView.layer.cornerRadius = 10;
        self.layer.shadowColor = UIColor.blackColor.CGColor;
        self.layer.shadowOffset = CGSizeMake(0.0, 5.0);
        self.layer.shadowRadius = 5.0;
        self.layer.shadowOpacity = 0.3;
    }
    return self;
}

- (void)setupWithTheme:(PSATheme *)theme {
    if (theme == nil) {
        return;
    }

    self.fromTitleLabel.textColor = [theme getColorForKey:PSAThemeInfoSectionTitleColorKey];
    self.fromValueLabel.textColor = [theme getColorForKey:PSAThemeInfoSectionValueColorKey];
    self.fromValueLabel.text = theme.title;
    self.messageLabel.textColor = [theme getColorForKey:PSAThemeMessageTextColorKey];
    self.contentView.backgroundColor = [theme getColorForKey:PSAThemeAuthInfoBackgroundColorKey];

    if (theme.logo) {
        [self.logoImage setHidden:NO];
        self.logoImage.image = theme.logo;
        CGRect expectedLogoSize = CGRectMake(0, 0, 200, 44);
        CGRect imageRect = AVMakeRectWithAspectRatioInsideRect(theme.logo.size, expectedLogoSize);
        self.logoImage.frame = CGRectMake(0, 0, imageRect.size.width, imageRect.size.height);
        [self.logoImage.heightAnchor constraintEqualToConstant:imageRect.size.height].active = YES;
        [self.logoImage.widthAnchor constraintEqualToConstant:imageRect.size.width].active = YES;
        self.logoImage.contentMode = UIViewContentModeScaleAspectFit;
    }
}

#pragma mark - XIBControl

- (UIView *)fetchContentView {
    return self.contentView;
}

@end

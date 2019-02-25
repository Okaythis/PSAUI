//
//  PSAKeyboard.m
//  PSA
//
//  Created by Sadovsky, Aleksandr on 8/27/18.
//

#import "PSAKeyboard.h"

@interface PSAKeyboard()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdButton;
@property (weak, nonatomic) IBOutlet UIButton *forthButton;
@property (weak, nonatomic) IBOutlet UIButton *fifthButton;
@property (weak, nonatomic) IBOutlet UIButton *sixthButton;
@property (weak, nonatomic) IBOutlet UIButton *seventhButton;
@property (weak, nonatomic) IBOutlet UIButton *eigthButton;
@property (weak, nonatomic) IBOutlet UIButton *ninthButton;
@property (weak, nonatomic) IBOutlet UIButton *tenthButton;
@property (strong, nullable) NSMutableArray<UIButton *> *valueButtons;
@end

@implementation PSAKeyboard

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self buttonsInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buttonsInit];
    }
    return self;
}

- (void)setupWithTheme:(PSATheme *)theme {
    if (!theme) {
        return;
    }

    for (NSInteger i = 0; i < [self.valueButtons count]; i++) {
        UIButton *button = self.valueButtons[i];
        UIColor *buttonTitleColor = [theme getColorForKey:PSAThemePinNumberButtonTextColorKey];
        [button setTitleColor:buttonTitleColor forState:UIControlStateNormal];
        button.backgroundColor = [theme getColorForKey:PSAThemePinNumberButtonBackgroundColorKey];
    }
}

#pragma mark - XIBControl

- (UIView *)fetchContentView {
    return self.contentView;
}

#pragma mark - Private

- (void)buttonsInit {
    self.valueButtons = [NSMutableArray arrayWithObjects:self.firstButton, self.secondButton, self.thirdButton,
                         self.forthButton, self.fifthButton, self.sixthButton, self.seventhButton, self.eigthButton,
                         self.ninthButton, self.tenthButton, nil];
    [self setButtonsValues:self.valueButtons];
}

- (void)setButtonsValues:(NSMutableArray<UIButton *> *)buttons {
    [self shuffle:buttons];
    for (NSInteger i = 0; i < [buttons count]; i++) {
        [buttons[i] setTitle:[@(i) stringValue] forState:UIControlStateNormal];
    }
}

- (void)shuffle:(NSMutableArray *)array {
    NSUInteger count = [array count];
    if (count <= 1) {
        return;
    }
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [array exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}

#pragma mark - Action

- (IBAction)valueButtonAction:(UIButton *)sender {
    if (self.delegate != nil) {
        [self.delegate valueButtonPressed:sender.currentTitle];
    }
}

@end

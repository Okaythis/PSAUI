//
//  PinViewController.m
//  PSAUI
//
//  Created by Sadovsky, Aleksandr on 8/28/18.
//

#import "PSAPinViewController.h"
#import "PSAKeyboard.h"
#import "PSAAuthInfo.h"
#import "PSASecurityProtocol.h"

//TODO Use LinkageTextField instead of separate text fields directly
@interface PSAPinViewController () <PSAKeyboardDelegate, PSASecurityProtocol>
@property (strong, nonatomic) PSATheme *theme;
@property (weak, nonatomic) id<PSAPinViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstPinLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondPinLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdPinLabel;
@property (weak, nonatomic) IBOutlet UILabel *forthPinLabel;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;
@property (weak, nonatomic) IBOutlet PSAKeyboard *keyboard;
@property (weak, nonatomic) IBOutlet PSAAuthInfo *authInfo;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (nullable) NSMutableString *pin;
@property (strong) NSArray<UILabel *> *pinLabels;
@end

@implementation PSAPinViewController
static NSInteger const pinSize = 4;
static NSString * const placeholderSymbol = @"•";

+ (instancetype)controllerWithTheme:(PSATheme *)theme delegate:(id<PSAPinViewControllerDelegate>)delegate {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PSAAuthViewController"
                                                         bundle:[NSBundle bundleForClass:self]];
    PSAPinViewController *vc = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
    vc.delegate = delegate;
    vc.theme = theme;
    vc.pin = [NSMutableString new];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.pinLabels = @[self.firstPinLabel, self.secondPinLabel, self.thirdPinLabel, self.forthPinLabel];

    [self setupTheme];
    self.keyboard.delegate = self;
}

#pragma mark - PSAKeyboardDelegate

- (void)valueButtonPressed:(nonnull NSString *)key {
    if (self.pin.length == pinSize) {
        return;
    }
    [self.pin appendString:key];
    self.pinLabels[self.pin.length - 1].text = key;
}

#pragma mark - Action

- (IBAction)removeAction {
    if (self.pin.length == 0) {
        return;
    }
    [self.pin deleteCharactersInRange:NSMakeRange(self.pin.length - 1, 1)];
    self.pinLabels[self.pin.length].text = placeholderSymbol;
}

- (IBAction)cancelAction {
    if (self.delegate != nil) {
        [self.delegate authCancel];
    }
    [self.view setUserInteractionEnabled:NO];
}

- (IBAction)confirmAction {
    if (self.delegate != nil) {
        [self.delegate authComplete:self.pin];
    }
    [self.view setUserInteractionEnabled:NO];
}

#pragma mark - Private

- (void)setupTheme {
    if (!self.theme) {
        return;
    }

    self.titleLabel.textColor = [self.theme getColorForKey:PSAThemePinTitleTextColorKey];
    [self setupPinLabelsTheme];
    [self setupRemoveButtonTheme];
    [self.keyboard setupWithTheme:self.theme];
    [self.authInfo setupWithTheme:self.theme];
    [self setupCancelButtonTheme];
    [self setupConfirmButtonColor];
    self.view.backgroundColor = [self.theme getColorForKey:PSAThemeScreenBackgroundColorKey];
}

- (void)setupPinLabelsTheme {
    for (NSInteger i = 0; i < [self.pinLabels count]; i++) {
        self.pinLabels[i].textColor = [self.theme getColorForKey:PSAThemePinValueTextColorKey];
    }
}

- (void)setupRemoveButtonTheme {
    UIColor *removeTitleColor = [self.theme getColorForKey:PSAThemePinRemoveButtonTextColorKey];
    [self.removeButton setTitleColor:removeTitleColor forState:UIControlStateNormal];
    self.removeButton.backgroundColor = [self.theme getColorForKey:PSAThemePinRemoveButtonBackgroundColorKey];
}

//TODO Extract buttons theming common with PSACommitAuthViewController

- (void)setupCancelButtonTheme {
    UIColor *cancelTitleColor = [self.theme getColorForKey:PSAThemeCancelButtonTextColorKey];
    [self.cancelButton setTitleColor:cancelTitleColor forState:UIControlStateNormal];
    self.cancelButton.backgroundColor = [self.theme getColorForKey:PSAThemeCancelButtonBackgroundColorKey];
}

- (void)setupConfirmButtonColor {
    UIColor *confirmTitleColor = [self.theme getColorForKey:PSAThemeConfirmButtonTextColorKey];
    [self.confirmButton setTitleColor:confirmTitleColor forState:UIControlStateNormal];
    self.confirmButton.backgroundColor = [self.theme getColorForKey:PSAThemeConfirmButtonBackgroundColorKey];
}

- (void)setDataHidden:(BOOL)isDataHidden {
    [_firstPinLabel setHidden:isDataHidden];
    [_secondPinLabel setHidden:isDataHidden];
    [_thirdPinLabel setHidden:isDataHidden];
    [_forthPinLabel setHidden:isDataHidden];
}

@end

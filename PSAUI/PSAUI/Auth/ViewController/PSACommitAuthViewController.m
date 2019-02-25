//
//  PSACommitAuthViewController.m
//  PSA
//
//  Created by Pivulski, Nikolai on 05.07.2018.
//

@import AVFoundation;
#import <PSACommon/PSACommon.h>
#import "PSACommitAuthViewController.h"
#import "PSAAuthInfo.h"

@interface PSACommitAuthViewController ()
@property (weak, nonatomic) id<PSACommitAuthViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *transactionTypeLabel;
@property (weak, nonatomic) IBOutlet PSAAuthInfo *authInfo;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (strong, nonatomic) PSATheme *theme;
@end

@implementation PSACommitAuthViewController

+ (instancetype)controllerWithTheme:(PSATheme *)theme delegate:(id<PSACommitAuthViewControllerDelegate>)delegate {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PSAAuthViewController"
                                                         bundle:[NSBundle bundleForClass:self]];
    PSACommitAuthViewController *vc = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
    vc.delegate = delegate;
    vc.theme = theme;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTheme];
}

- (void)setupTheme {
    if (!self.theme) {
        return;
    }

    [self.authInfo setupWithTheme:self.theme];
    [self changeTitleColor];
    [self changeQuestionMarkColor];
    [self setupCancelButtonTheme];
    [self setupConfirmButtonColor];
    self.transactionTypeLabel.textColor = [self.theme getColorForKey:PSAThemeTransactionTypeTextColorKey];
    self.view.backgroundColor = [self.theme getColorForKey:PSAThemeScreenBackgroundColorKey];
}

#pragma mark - Private

- (void)changeTitleColor {
    NSAttributedString *title = self.titleLabel.attributedText;
    NSRange range = (NSRange){0, [title length] - 1};
    UIColor *color = [self.theme getColorForKey:PSAThemeTitleTextColorKey];
    self.titleLabel.attributedText = [PSAAttributedStringUtils createFromAttributedString:title
                                                                                  inRange:range
                                                                                withColor:color];
}

- (void)changeQuestionMarkColor {
    NSAttributedString *title = self.titleLabel.attributedText;
    NSRange range = (NSRange){[title length] - 1, 1};
    UIColor *color = [self.theme getColorForKey:PSAThemeQuestionMarkColorKey];
    self.titleLabel.attributedText = [PSAAttributedStringUtils createFromAttributedString:title
                                                                                  inRange:range
                                                                                withColor:color];
}

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

#pragma mark - Action

- (IBAction)confirmAction {
    [self.delegate commitAuthViewControllerConfirmed:self];
}

- (IBAction)cancelAction {
    [self.delegate commitAuthViewControllerCancelled:self];
}

@end

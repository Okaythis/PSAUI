//
//  PSAAuthViewController.m
//  PSA
//
//  Created by Pivulski, Nikolai on 25.06.2018.
//

#import <PSACommon/PSACommon.h>
#import "PSAAuthViewController.h"
#import "PSACommon/PSAAuthController.h"
#import "PSACommitAuthViewController.h"
#import "PSAPinViewController.h"
#import "PSACommon/PSAUserAnswer.h"

@interface PSAAuthViewController () <PSAAuthControllerDelegate,
                                     PSACommitAuthViewControllerDelegate,
                                     PSAPinViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) PSAAuthController *authController;
@property (strong) NSNumber *sessionId;
@property (copy, nonatomic) void (^completion)(BOOL, PSASharedStatuses);
@property (strong, nonatomic) PSATheme *theme;
@property (assign) BOOL cancelled;
@property (strong) NSMutableArray<PSASessionArtifact *> *artifacts;
@end

@implementation PSAAuthViewController

+ (instancetype)controllerWithTheme:(PSATheme *)theme
                          sessionId:(NSNumber *)sessionId
                         completion:(void (^)(BOOL, PSASharedStatuses))completion {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass(self)
                                                         bundle:[NSBundle bundleForClass:self]];
    PSAAuthViewController *vc = [storyboard instantiateInitialViewController];
    vc.sessionId = sessionId;
    vc.completion = completion;
    vc.theme = theme;
    vc.artifacts = [NSMutableArray new];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.theme != nil) {
        self.view.backgroundColor = [self.theme getColorForKey:PSAThemeScreenBackgroundColorKey];
        self.activityIndicator.color = [self.theme getColorForKey:PSAThemeActivityIndicatorColor];
    }
    if (self.view.backgroundColor == nil) {
        self.view.backgroundColor = UIApplication.sharedApplication.keyWindow.tintColor;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (!self.authController) {
        self.authController = [[PSAAuthController alloc] initWithSessionId:self.sessionId];
        self.authController.delegate = self;
        [self.authController start];
    }
}

#pragma mark - PSAAuthControllerDelegate

- (void)authControllerFinishedAuthPrepare:(PSAAuthController *)controller {
    if ([PSAAuthControllerPinChainType isEqualToString:controller.chainType]) {
        [self presentViewController:[PSAPinViewController controllerWithTheme:self.theme delegate:self]];
    } else {
        [self presentViewController:[PSACommitAuthViewController controllerWithTheme:self.theme delegate:self]];
    }
}

- (void)clientActionController:(PSABaseClientActionController *)controller finishedWithStatus:(PSASharedStatuses)status {
    [self dismissViewControllerAnimated:NO completion:nil];
    //TODO Process errors
    if (self.completion) {
        self.completion(self.cancelled, status);
        self.completion = nil;
    }
}

#pragma mark - PSACommitAuthViewControllerDelegate

- (void)commitAuthViewControllerCancelled:(PSACommitAuthViewController *)controller {
    [self cancelAuth];
}

- (void)commitAuthViewControllerConfirmed:(PSACommitAuthViewController *)controller {
    self.cancelled = NO;
    [self commitAuth:PSAUserAnswerOk];
}

#pragma mark - PinViewControllerDelegate

- (void)authComplete:(NSString *)pin {
    [self commitAuth:pin];
}

- (void)authCancel {
    [self cancelAuth];
}

#pragma mark - Private

- (void)presentViewController:(UIViewController *)vc {
    if (self.presentedViewController) {
        [self.presentedViewController presentViewController:vc animated:YES completion:nil];
    } else {
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (void)commitAuth:(NSString *)userAnswer {
    __weak __typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:NO completion:^{
        [weakSelf.authController commitAuth:userAnswer];
    }];
}

- (void)cancelAuth {
    self.cancelled = YES;
    __weak __typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:NO completion:^{
        [weakSelf.authController cancelAuth];
    }];
}

@end

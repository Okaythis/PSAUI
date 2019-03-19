//
//  PSAEnrollmentViewController.m
//  PSAUI
//
//  Created by Pivulski, Nikolai on 12/06/2018.
//

#import "PSAEnrollmentViewController.h"
#import "PSACommon/PSAEnrollmentController.h"
#import "PSACommon/PSASharedStatuses.h"

@interface PSAEnrollmentViewController () <PSABaseClientActionControllerDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) PSAEnrollmentController *enrollmentController;
@property (copy, nonatomic) void (^completion)(PSASharedStatuses);
@end

@implementation PSAEnrollmentViewController

+ (instancetype)controllerWithCompletion:(void (^)(PSASharedStatuses))completion {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass(self)
                                                         bundle:[NSBundle bundleForClass:self]];
    PSAEnrollmentViewController *vc = [storyboard instantiateInitialViewController];
    vc.completion = completion;
    return vc;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.enrollmentController = [[PSAEnrollmentController alloc] init];
    self.enrollmentController.delegate = self;
    [self.enrollmentController start];
}

#pragma mark - PSABaseClientActionControllerDelegate

- (void)clientActionController:(PSABaseClientActionController *)controller finishedWithStatus:(PSASharedStatuses)status {
    [self dismissViewControllerAnimated:NO completion:nil];
    if (self.completion) {
        self.completion(status);
        self.completion = nil;
    }
}

@end

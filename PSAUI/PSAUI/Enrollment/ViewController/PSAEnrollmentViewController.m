//
//  PSAEnrollmentViewController.m
//  PSA
//
//  Created by Pivulski, Nikolai on 12/06/2018.
//

#import "PSAEnrollmentViewController.h"
#import "PSACommon/PSASharedStatuses.h"

@interface PSAEnrollmentViewController () <PSABaseClientActionControllerDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, weak, nullable) id<PSAEnrollmentControllerDelegate> delegate;
@property (copy, nonatomic) void (^completion)(PSASharedStatuses);
@end

@implementation PSAEnrollmentViewController

+ (instancetype)controllerWithCompletion:(void (^)(PSASharedStatuses))completion
                                delegate:(id<PSAEnrollmentControllerDelegate>) delegate; {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass(self)
                                                         bundle:[NSBundle bundleForClass:self]];
    PSAEnrollmentViewController *vc = [storyboard instantiateInitialViewController];
    vc.completion = completion;
    vc.delegate = delegate;
    return vc;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.delegate viewWillAppearWith:self];
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

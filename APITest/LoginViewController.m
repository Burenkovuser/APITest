//
//  LoginViewController.m
//  APITest
//
//  Created by Vasilii on 31.07.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "LoginViewController.h"
#import "AccessToken.h"

@interface LoginViewController ()

@property (copy, nonatomic) LoginCompletionBlock completionBlock;

@end

@implementation LoginViewController

- (id) initWithCompletionBlock:(LoginCompletionBlock) completionBlock {

self = [super init];
if (self) {
    
    self.completionBlock = completionBlock;
}
return self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // добавляем вебвью
    CGRect r = self.view.bounds;
    r.origin = CGPointZero;
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:r];
    
    webview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth ;
    
    [self.view addSubview:webview];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                          target:self
                                                                          action:@selector(actionCancel:)];
    [self.navigationItem setRightBarButtonItem:item animated:NO];
    
    self.navigationItem.title = @"Login";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void) actionCancel:(UIBarButtonItem *) item {
    
    if (self.completionBlock) {
        self.completionBlock(nil);
    }
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

@end

//
// Created by sail on 10/20/13.
// Copyright (c) 2013 sail. All rights reserved.
//


#import "PageViewController.h"
#import "BaseNavigationController.h"
#import "HLService.h"

@implementation PageViewController {
  NSURL *_url;
  UIWebView *_webView;
  UIBarButtonItem *_forwardBarItem;
  UIBarButtonItem *_backBarItem;
  UITextField *_addressBar;
  UIButton *_refreshBtn;
  UIButton *_deleteBtn;
  bool _needSave;
}


- (id)initWithURL:(NSURL *)url needSave:(bool)needSave {
  self = [super init];
  if (self) {
    _url = url;
    _needSave = needSave;
    NSArray *cachedData = [[NSUserDefaults standardUserDefaults] arrayForKey:@"history"];
    if ([cachedData containsObject:url.absoluteString]) {
      _needSave = false;
    }
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  _refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  _refreshBtn.frame = CGRectMake(0, 0, 18, 17);
  [_refreshBtn setImage:[UIImage imageNamed:@"refresh_btn"] forState:UIControlStateNormal];
  [_refreshBtn setImage:[UIImage imageNamed:@"refresh_btn"] forState:UIControlStateHighlighted];
  [_refreshBtn addTarget:self action:@selector(refreshBtnPressed) forControlEvents:UIControlEventTouchUpInside];

  _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  _deleteBtn.frame = CGRectMake(0, 0, 18, 18);
  [_deleteBtn setImage:[UIImage imageNamed:@"delete_btn"] forState:UIControlStateNormal];
  [_deleteBtn setImage:[UIImage imageNamed:@"delete_btn"] forState:UIControlStateHighlighted];
  [_deleteBtn addTarget:self action:@selector(deleteBtnPressed) forControlEvents:UIControlEventTouchUpInside];

  UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  [backBtn setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
  [backBtn setImage:[UIImage imageNamed:@"back_disabled"] forState:UIControlStateDisabled];
  [backBtn addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  [backBtn sizeToFit];
  _backBarItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//  _backBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_btn"]
//                                                                  style:UIBarButtonItemStylePlain
//                                                                 target:self
//                                                                 action:@selector(backButtonPressed)];
  _backBarItem.enabled = false;

  UIButton *forwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  [forwardBtn setImage:[UIImage imageNamed:@"forward_btn"] forState:UIControlStateNormal];
  [forwardBtn setImage:[UIImage imageNamed:@"forward_disabled"] forState:UIControlStateDisabled];
  [forwardBtn addTarget:self action:@selector(forwardButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  [forwardBtn sizeToFit];
  _forwardBarItem = [[UIBarButtonItem alloc] initWithCustomView:forwardBtn];
//  _forwardBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forward_btn.png"]
//                                                                  style:UIBarButtonItemStylePlain
//                                                                 target:self
//                                                                 action:@selector(forwardButtonPressed)];
  _forwardBarItem.enabled = false;
//  UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
  UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                              target:nil
                                                                              action:nil];
    fixedSpace.width = 25;
    
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 58, 47);
    [menuBtn setTitle:@"菜单" forState:UIControlStateNormal];
    [menuBtn setTitle:@"菜单" forState:UIControlStateHighlighted];
    [menuBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [menuBtn addTarget:(BaseNavigationController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *_menuBarItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    
  [self.navigationItem setLeftBarButtonItems:@[_menuBarItem, fixedSpace, _backBarItem, fixedSpace,
    _forwardBarItem]                animated:YES];


  _addressBar = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 130, 20)];
  _addressBar.textAlignment = NSTextAlignmentRight;

  _addressBar.delegate = self;
  _addressBar.text = [_url absoluteString];
  [_addressBar setRightViewMode:UITextFieldViewModeAlways];
  [_addressBar setRightView:_refreshBtn];

  self.navigationItem.titleView = _addressBar;


  [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title"] forBarMetrics:UIBarMetricsDefault];

  _webView = [[UIWebView alloc] init];
    _webView.delegate = self;
    [_webView loadRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:@"http://www.soku.com/m/y/video?q=%E7%BE%8E%E5%A5%B3#loaded"]]];
  self.view = _webView;
}

- (void)deleteBtnPressed {
  NSLog(@"Delete");
  _addressBar.text = @"";
}

- (void)chaping {

//    [[AppDelegate shareInstance] chaping];
    
    [[HLPopupManager sharedManager] showRate:^{
        
    } and:^{
        
    }];
}

- (void)refreshBtnPressed {
  NSLog(@"Refresh");
  [_webView reload];
    [self chaping];
}

- (void)forwardButtonPressed {
    [_webView goForward];
    [self chaping];
}

- (void)backButtonPressed {
    [_webView goBack];
    [self chaping];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

  NSString *title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
  if (_needSave && title.length > 0) {
    NSArray *cachedData = [[NSUserDefaults standardUserDefaults] arrayForKey:@"history"];
    if (cachedData == nil) {
      cachedData = [[NSArray alloc] init];
    }
    [[NSUserDefaults standardUserDefaults] setObject:[cachedData arrayByAddingObject:_addressBar.text] forKey:@"history"];
    NSDictionary *urlCached = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"history_url"];
    NSMutableDictionary *urlDict;
    if (cachedData == nil) {
      urlDict = [[NSMutableDictionary alloc] init];
    }
    else {
      urlDict = [NSMutableDictionary dictionaryWithDictionary:urlCached];
    }
    [urlDict setObject:title forKey:_addressBar.text];
    [[NSUserDefaults standardUserDefaults] setObject:urlDict forKey:@"history_url"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _needSave = false;
  }
  _backBarItem.enabled = _webView.canGoBack;
  _forwardBarItem.enabled = _webView.canGoForward;
    _addressBar.text = _webView.request.URL.absoluteString;
    [self chaping];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  NSLog(@"Begin edit");
  [_addressBar setRightView:_deleteBtn];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  [_addressBar setRightView:_refreshBtn];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [_webView loadRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:_addressBar.text]]];
  _needSave = true;
  [_addressBar resignFirstResponder];
  return NO;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
//
// Created by sail on 10/20/13.
// Copyright (c) 2013 sail. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface PageViewController : UIViewController <UIWebViewDelegate, UITextFieldDelegate>
- (id)initWithURL:(NSURL *)url needSave:(bool)needSave;

@end
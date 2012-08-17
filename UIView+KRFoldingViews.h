//
//  UIView+KROrigami.h
//  KRFoldingViews
//
//  Created by Kishyr Ramdial on 2012/08/09.
//  Copyright (c) 2012 entropy|one. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KROrigami)

- (void)dropIn;
- (void)dropIn:(void (^)(void))completionBlock;

- (void)foldLeftFromView:(UIView *)originalView;
- (void)foldLeftFromView:(UIView *)originalView completion:(void (^)(UIView *previousView))completionBlock;

- (void)foldRightFromView:(UIView *)originalView;
- (void)foldRightFromView:(UIView *)originalView completion:(void (^)(UIView *previousView))completionBlock;

- (void)foldDownFromView:(UIView *)originalView;
- (void)foldDownFromView:(UIView *)originalView completion:(void (^)(UIView *previousView))completionBlock;

- (void)foldUpFromView:(UIView *)originalView;
- (void)foldUpFromView:(UIView *)originalView completion:(void (^)(UIView *previousView))completionBlock;

+ (void)foldViews:(NSArray *)views inDirections:(NSString *)directions fromOriginalView:(UIView *)originalView;

@end

//
//  UIView+KROrigami.m
//  KRFoldingViews
//
//  Created by Kishyr Ramdial on 2012/08/09.
//  Copyright (c) 2012 entropy|one. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


#import "UIView+KRFoldingViews.h"
#import <QuartzCore/QuartzCore.h>

// Set the animation speed
#define ANIMATION_SPEED 1.5


@implementation UIView (KROrigami)

// Basic Animations
- (CABasicAnimation *)origamiFoldLeft {
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
	[animation setFromValue:[NSNumber numberWithFloat:180/(180/M_PI)]];
	[animation setToValue:[NSNumber numberWithFloat:0]];
	[animation setDuration:ANIMATION_SPEED];
	
	return animation;
}

- (CABasicAnimation *)origamiFoldRight {
	CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
	[animation2 setFromValue:[NSNumber numberWithFloat:-180/(180/M_PI)]];
	[animation2 setToValue:[NSNumber numberWithFloat:0]];
	[animation2 setDuration:ANIMATION_SPEED];
	
	return animation2;
}

- (CABasicAnimation *)origamiFoldDown {
	CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
	[animation3 setFromValue:[NSNumber numberWithFloat:-180/(180/M_PI)]];
	[animation3 setToValue:[NSNumber numberWithFloat:0]];
	[animation3 setDuration:ANIMATION_SPEED];
	
	return animation3;
}

- (CABasicAnimation *)origamiFoldUp {
	CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
	[animation4 setFromValue:[NSNumber numberWithFloat:180/(180/M_PI)]];
	[animation4 setToValue:[NSNumber numberWithFloat:0]];
	[animation4 setDuration:ANIMATION_SPEED];
	
	return animation4;
}

- (CABasicAnimation *)scaleDown {
	CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	[animation4 setFromValue:[NSNumber numberWithFloat:1.5]];
	[animation4 setToValue:[NSNumber numberWithFloat:1.0]];
	[animation4 setDuration:ANIMATION_SPEED/2];
	
	return animation4;
}

- (CABasicAnimation *)fadeIn {
	CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"opacity"];
	[animation4 setFromValue:[NSNumber numberWithFloat:0.5]];
	[animation4 setToValue:[NSNumber numberWithFloat:1]];
	[animation4 setDuration:ANIMATION_SPEED/2];
	
	return animation4;
}


// Drop-in effect

- (void)dropIn {
	[self.layer addAnimation:[self scaleDown] forKey:@"scale"];
	[self.layer addAnimation:[self fadeIn] forKey:@"opacity"];
}

- (void)dropIn:(void (^)(void))completionBlock {
	[self dropIn];
	
	double delayInSeconds = ANIMATION_SPEED/2;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    completionBlock();
	});
}


// Fold Right

- (void)foldRightFromView:(UIView *)originalView {
	self.hidden = NO;
	self.layer.anchorPoint = CGPointMake(0, 0.5);
	self.frame = CGRectMake(CGRectGetMaxX(originalView.frame), CGRectGetMinY(originalView.frame), CGRectGetWidth(originalView.frame), CGRectGetHeight(originalView.frame));
	[self.layer addAnimation:[self origamiFoldLeft] forKey:@"transform.rotation.y"];
}

- (void)foldRightFromView:(UIView *)originalView completion:(void (^)(UIView *previousView))completionBlock {
	[self foldRightFromView:originalView];
	
	double delayInSeconds = ANIMATION_SPEED;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    completionBlock(self);
	});
}


// Fold Left

- (void)foldLeftFromView:(UIView *)originalView {
	self.hidden = NO;
	self.layer.anchorPoint = CGPointMake(1, 0.5);
	self.frame = CGRectMake(CGRectGetMinX(originalView.frame)-CGRectGetWidth(originalView.frame), CGRectGetMinY(originalView.frame), CGRectGetWidth(originalView.frame), CGRectGetHeight(originalView.frame));
	[self.layer addAnimation:[self origamiFoldRight] forKey:@"transform.rotation.y"];
}

- (void)foldLeftFromView:(UIView *)originalView completion:(void (^)(UIView *previousView))completionBlock {
	[self foldLeftFromView:originalView];
	
	double delayInSeconds = ANIMATION_SPEED;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    completionBlock(self);
	});
}


// Fold Down

- (void)foldDownFromView:(UIView *)originalView {
	self.hidden = NO;
	self.layer.anchorPoint = CGPointMake(0.5, 0);
	self.frame = CGRectMake(CGRectGetMinX(originalView.frame), CGRectGetMaxY(originalView.frame), CGRectGetWidth(originalView.frame), CGRectGetHeight(originalView.frame));;
	[self.layer addAnimation:[self origamiFoldDown] forKey:@"transform.rotation.x"];
}

- (void)foldDownFromView:(UIView *)originalView completion:(void (^)(UIView *previousView))completionBlock {
	[self foldDownFromView:originalView];
	
	double delayInSeconds = ANIMATION_SPEED;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    completionBlock(self);
	});
}


// Fold Up

- (void)foldUpFromView:(UIView *)originalView {
	self.hidden = NO;
	self.layer.anchorPoint = CGPointMake(0.5, 1);
	self.frame = CGRectMake(CGRectGetMinX(originalView.frame), CGRectGetMinY(originalView.frame)-CGRectGetHeight(originalView.frame), CGRectGetWidth(originalView.frame), CGRectGetHeight(originalView.frame));
	[self.layer addAnimation:[self origamiFoldUp] forKey:@"transform.rotation.x"];
}

- (void)foldUpFromView:(UIView *)originalView completion:(void (^)(UIView *previousView))completionBlock {
	[self foldUpFromView:originalView];
	
	double delayInSeconds = ANIMATION_SPEED;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    completionBlock(self);
	});
}


// Fold all given views (in an array) in given directions (a string of "up, down, left, right"). If the number
// of directions is less than the number of views, the last direction is used for the remaining views.

+ (void)foldViews:(NSArray *)views inDirections:(NSString *)directions fromOriginalView:(UIView *)originalView {
	NSArray *allDirections = [[directions lowercaseString] componentsSeparatedByString:@","];
	
	if ([views count] != [allDirections count]) {
		NSMutableArray *d_ = [NSMutableArray arrayWithCapacity:[views count]];
		for (int i = 0; i < [views count]; i++) {
			@try {
				[d_ addObject:[allDirections objectAtIndex:i]];
			}
			@catch (NSException *exception) {
				[d_ addObject:[allDirections lastObject]];
			}
			@finally {}
		}
		allDirections = [NSArray arrayWithArray:d_];
	}
	
	NSMutableArray *completionBlocks = [NSMutableArray arrayWithCapacity:[allDirections count]];
	typedef void (^FoldingViewBlock)(void);
	
	NSInteger counter = 1;
	for (NSString *direction in [allDirections reverseObjectEnumerator]) {		
		NSString *d = [[direction stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] capitalizedString];
		
		FoldingViewBlock previousCompletionBlock;
		if ([completionBlocks count] > 0)
			previousCompletionBlock = [completionBlocks objectAtIndex:0];
		
		UIView *thisView = [views objectAtIndex:([views count]-counter)];
		UIView *previousView;
		if (thisView == [views objectAtIndex:0])
			previousView = originalView;
		else
			previousView = [views objectAtIndex:([views count] - counter - 1)];
		
		BOOL firstElement = thisView == [views lastObject];
		NSString *selectorString = [NSString stringWithFormat:@"fold%@FromView:%@", d, (firstElement ? @"" : @"completion:")];

		
		FoldingViewBlock completionBlock = ^{
			SEL selector = NSSelectorFromString(selectorString);
			if (firstElement)
				[thisView performSelector:selector withObject:previousView];
			else
				[thisView performSelector:selector withObject:previousView withObject:previousCompletionBlock];
		};
		[completionBlocks insertObject:completionBlock atIndex:0];
		
		counter++;
	}
	
	((FoldingViewBlock)[completionBlocks objectAtIndex:0])();

}


@end

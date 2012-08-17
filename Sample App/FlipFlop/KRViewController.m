//
//  KRViewController.m
//  FlipFlop
//
//  Created by Kishyr Ramdial on 2012/08/13.
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


#import "KRViewController.h"
#import "UIView+KRFoldingViews.h"
#import <QuartzCore/QuartzCore.h>

@interface KRViewController ()
@property (nonatomic, strong) NSMutableArray *colorViews;
@property (nonatomic, strong) UIImageView *originalView;
@end

@implementation KRViewController

- (void)basicFolds {
	self.colorViews = [NSMutableArray array];
	
	for (int i = 0; i<9; i++) {
		UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
		v.center = self.view.center;
		v.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i]];
		[self.colorViews addObject:v];
	}
	
	UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
	v.center = self.view.center;
	v.backgroundColor = [UIColor yellowColor];
	
	[v dropIn:^{
		[self.colorViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			[self.view addSubview:obj];
		}];
		[self.view bringSubviewToFront:v];
		
		
		UIView *q0 = [self.colorViews objectAtIndex:0];
		UIView *q1 = [self.colorViews objectAtIndex:1];
//		UIView *q2 = [self.colorViews objectAtIndex:2];
//		UIView *q3 = [self.colorViews objectAtIndex:3];
//		UIView *q4 = [self.colorViews objectAtIndex:4];
//		UIView *q5 = [self.colorViews objectAtIndex:5];
		
		[q0 foldDownFromView:v];
		[q1 foldUpFromView:v];
		
	}];
	[self.view addSubview:v];
}

- (void)blockFolding {
	self.colorViews = [NSMutableArray array];
	
	for (int i = 0; i<9; i++) {
		UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
		v.center = self.view.center;
		v.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i]];
		[self.colorViews addObject:v];
	}
	
	UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
	v.center = self.view.center;
	v.backgroundColor = [UIColor yellowColor];
	
	[v dropIn:^{
		[self.colorViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			[self.view addSubview:obj];
		}];
		[self.view bringSubviewToFront:v];
		
		
		UIView *q0 = [self.colorViews objectAtIndex:0];
		UIView *q1 = [self.colorViews objectAtIndex:1];
		UIView *q2 = [self.colorViews objectAtIndex:2];
		UIView *q3 = [self.colorViews objectAtIndex:3];
		UIView *q4 = [self.colorViews objectAtIndex:4];
		UIView *q5 = [self.colorViews objectAtIndex:5];
		UIView *q6 = [self.colorViews objectAtIndex:6];
		UIView *q7 = [self.colorViews objectAtIndex:7];

		[q0 foldLeftFromView:v];
		[q1 foldRightFromView:v];
		[q2 foldUpFromView:v];

		[q3 foldDownFromView:v completion:^(UIView *previousView) {
			[q4 foldRightFromView:previousView completion:^(UIView *previousView) {
				[q5 foldLeftFromView:q2 completion:^(UIView *previousView) {
					[q6 foldRightFromView:q2 completion:^(UIView *previousView) {
						[q7 foldLeftFromView:q3];
					}];
				}];
			}];
		}];
				
	}];
	[self.view addSubview:v];
}

- (void)stringBasedFolding {
	self.colorViews = [NSMutableArray array];
	
	for (int i = 0; i<9; i++) {
		UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
		v.center = self.view.center;
		v.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i]];
		[self.colorViews addObject:v];
	}
	
	UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
	v.center = self.view.center;
	v.backgroundColor = [UIColor yellowColor];
	
	[v dropIn:^{
		[self.colorViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			[self.view addSubview:obj];
		}];
		[self.view bringSubviewToFront:v];
		
				
		[UIView foldViews:self.colorViews inDirections:@"left, down, right, right, up, up, left, left, up" fromOriginalView:v];
				
	}];
	[self.view addSubview:v];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self performSelector:NSSelectorFromString(self.foldingMethod) withObject:nil];
}

- (void)viewDidUnload {
	[super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end

//
//  ViewController.m
//  TZFivePointedStar
//
//  Created by Zhou Hangqing on 14/7/27.
//  Copyright (c) 2014年 ThoughtEvilStudio. All rights reserved.
//

#import "ViewController.h"
#import "TZFivePointedStar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Boring me. Come up an idea to draw the China flag using the TZFivePointedStar
    
    // draw back to red
    self.view.backgroundColor = [UIColor redColor];

    // That's luckly our standard China flag is the ratio of 3 : 2, so we make out flag (960, 640);
    CGSize size = CGSizeMake(960.f, 640.f);
    // divide the sceen into four equal parts
    CGSize topLeftSize = CGSizeMake(size.width * 0.25f, size.height * 0.25f);
    // then divide top left rectangle into 15-colum 10-row equal parts
    CGSize unitSize = CGSizeMake(topLeftSize.width / 15.f, topLeftSize.height / 10.f);
    
    // the big star center should be at five times of unit size, means coordinate (5, 5)
    CGPoint bigStarCenter = CGPointMake(unitSize.width * 5, unitSize.height * 5);
    // radius of big star should be three times of unit height
    CGFloat radius = unitSize.height * 3;
    // draw big star
    UIImage *bigStarImage = [TZFivePointedStar startImageWithRadius:radius fillColor:[UIColor yellowColor] strokeWidth:1 strokeColor:nil];
    UIImageView *bigStar = [[UIImageView alloc] initWithImage:bigStarImage];
    [self.view addSubview:bigStar];
    bigStar.center = bigStarCenter;
    
    // Then start to draw the four small stars, one pointing of the small star should be point to center of the big star
    // radius of small star should be unit height
    radius = unitSize.height;
    UIImage *smallStarImage = [TZFivePointedStar startImageWithRadius:radius fillColor:[UIColor yellowColor] strokeWidth:1 strokeColor:nil];
    CGPoint centers[4];
    // first small star (10, 2)
    CGPoint smallStarCenter = CGPointMake(unitSize.width * 10, unitSize.height * 2);
    centers[0] = smallStarCenter;
    // second small star (12, 4)
    smallStarCenter = CGPointMake(unitSize.width * 12, unitSize.height * 4);
    centers[1] = smallStarCenter;
    // third small star (12, 7)
    smallStarCenter = CGPointMake(unitSize.width * 12, unitSize.height * 7);
    centers[2] = smallStarCenter;
    // fourth small star (10, 9)
    smallStarCenter = CGPointMake(unitSize.width * 10, unitSize.height * 9);
    centers[3] = smallStarCenter;
    
    for (int i = 0; i < 4; i++) {
        CGPoint smallStarCenter = centers[i];
        float angle = atan2f(smallStarCenter.y - bigStarCenter.y, smallStarCenter.x - bigStarCenter.x);
        // cause the star we create is top-bottom, so here we should adjust about it
        angle -= D2R(90.f);
        // draw small star
        UIImageView *smallStar = [[UIImageView alloc] initWithImage:smallStarImage];
        [self.view addSubview:smallStar];
        smallStar.center = smallStarCenter;
        smallStar.transform = CGAffineTransformMakeRotation(angle);
    }
    
    // done
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

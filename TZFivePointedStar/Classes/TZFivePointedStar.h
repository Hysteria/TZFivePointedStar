//
//  TZFivePointedStar.h
//  StarLevelBoard
//
//  Created by Zhou Hangqing on 14/7/12.
//  Copyright 2014年 ThoughtEvilStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define M_PI        3.14159265358979323846264338327950288

#define D2R(__ANGLE__) ((__ANGLE__) * 0.01745329252f) // PI / 180

#define R2D(__ANGLE__) ((__ANGLE__) * 57.29577951f) // PI * 180

@interface TZFivePointedStar : NSObject {
    
}

// retrieve a C styled array contains CGPoint with 10 lenght
+ (CGPoint *)pointsWithCenter:(CGPoint)center top:(CGPoint)top outputStarSize:(CGSize *)size;
+ (CGPoint *)pointsWithCenter:(CGPoint)center top:(CGPoint)top;
// retrieve a NSArray contains NSValue wrappered with CGPoint
+ (NSArray *)pointArrayWithCenter:(CGPoint)center top:(CGPoint)top outputStarSize:(CGSize *)size;
+ (NSArray *)pointArrayWithCenter:(CGPoint)center top:(CGPoint)top;

// retrieve the star image which could be cached using radius as key
+ (UIImage *)startImageWithRadius:(float)radius fillColor:(UIColor *)fillColor strokeWidth:(int)strokeWidth strokeColor:(UIColor *)strokeColor;
+ (void)clear;
@end

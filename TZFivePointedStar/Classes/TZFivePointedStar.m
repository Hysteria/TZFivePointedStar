//
//  TZFivePointedStar.m
//  StarLevelBoard
//
//  Created by Zhou Hangqing on 14/7/12.
//  Copyright 2014年 ThoughtEvilStudio. All rights reserved.
//

#import "TZFivePointedStar.h"

static NSMutableDictionary *cachedStars = nil;

@implementation TZFivePointedStar

+ (CGPoint)rotatePoint:(CGPoint)point center:(CGPoint)center degress:(float)degree
{
    float radian = D2R(degree);
    int x = center.x + (point.x - center.x) * cos(radian) - (point.y - center.y) * sin(radian);
    int y = center.y + (point.x - center.x) * sin(radian) + (point.y - center.y) * cos(radian);
    return CGPointMake(x, y);
}

+ (CGPoint *)pointsWithCenter:(CGPoint)center top:(CGPoint)top outputStarSize:(CGSize *)size
{
    CGPoint bl = CGPointZero;
    CGPoint tr = CGPointZero;
    
    float radius = powf(powf((top.x - center.x), 2.f) + powf((top.y - center.y), 2.f), 0.5f);
    CGPoint *points = (CGPoint *)malloc(sizeof(CGPoint) * 10);
    points[0] = top;
    points[1] = [self rotatePoint:points[0] center:center degress:36.0];
    int len = radius * (sin(D2R(18.)) / sin(D2R(126.)));
    points[1].x = center.x + len * ((points[1].x - center.x) / radius);
    points[1].y = center.y + len * ((points[1].y - center.y) / radius);
    
    for (int i = 1; i < 5; i++) {
        points[2 * i] = [self rotatePoint:points[2 * i - 2] center:center degress:72.];
        points[2 * i + 1] = [self rotatePoint:points[2 * i - 1] center:center degress:72.];
    }
    
    // get bottom left point and top right point
    for (int i = 0; i < 10; i++) {
        bl.x = MIN(bl.x, points[i].x);
        bl.y = MIN(bl.y, points[i].y);
        tr.x = MAX(tr.x, points[i].x);
        tr.y = MAX(tr.y, points[i].y);
    }
    *size = CGSizeMake(fabsf(tr.x - bl.x), fabs(tr.y - bl.y));
    return points;
}

+ (CGPoint *)pointsWithCenter:(CGPoint)center top:(CGPoint)top
{
    return [self pointsWithCenter:center top:top outputStarSize:nil];
}

+ (NSArray *)pointArrayWithCenter:(CGPoint)center top:(CGPoint)top outputStarSize:(CGSize *)size
{
    CGPoint *points = [self pointsWithCenter:center top:top outputStarSize:size];
    NSMutableArray *ptArr = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        [ptArr addObject:[NSValue valueWithCGPoint:points[i]]];
    }
    return [ptArr copy];
}

+ (NSArray *)pointArrayWithCenter:(CGPoint)center top:(CGPoint)top
{
    return [self pointArrayWithCenter:center top:top outputStarSize:nil];
}

+ (UIImage *)startImageWithRadius:(float)radius fillColor:(UIColor *)fillColor strokeWidth:(int)strokeWidth strokeColor:(UIColor *)strokeColor
{
    // remain two decimal as key
    NSString *key = [NSString stringWithFormat:@"%.2f", radius];
    UIImage *starImage = cachedStars[key];
    if (!starImage) {
        // make image high display
        float scale = [[UIScreen mainScreen] scale];
        radius *= scale;
        CGPoint center = CGPointMake(radius, radius);
        CGPoint top = CGPointMake(radius, 0);
        CGSize starSize = CGSizeZero;
        CGPoint *points = [TZFivePointedStar pointsWithCenter:center top:top outputStarSize:&starSize];
        CGPoint *pts = (CGPoint *)malloc(sizeof(CGPoint) * 11);
        
        for (int i = 0; i < 10; i++) {
            pts[i] = points[i];
        }
        pts[10] = points[0];
        
        UIGraphicsBeginImageContext(starSize);
        CGContextRef ct = UIGraphicsGetCurrentContext();
        
        CGContextBeginPath(ct);
        CGContextSetLineWidth(ct, strokeWidth);
        CGContextSetStrokeColorWithColor(ct, strokeColor.CGColor);
        CGContextSetFillColorWithColor(ct, fillColor.CGColor);
        CGContextAddLines(ct, pts, 11);
        CGContextFillPath(ct);
        CGContextClosePath(ct);
        
        CGImageRef imageRef = CGBitmapContextCreateImage(ct);
        starImage = [UIImage imageWithCGImage:imageRef scale:2.f orientation:UIImageOrientationUp];
        
        // cache star image
        cachedStars[key] = starImage;
    }
    
    return starImage;
}

+ (void)clear
{
    [cachedStars removeAllObjects];
}

@end

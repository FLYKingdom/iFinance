//
//  Utility.m
//  xinlife
//
//  Created by qianxun on 13-8-6.
//  Copyright (c) 2013年 com.qianxun. All rights reserved.
//

#import "MyUtility.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>
#import "HexColor.h"
 
@implementation MyUtility
static NSString *CSSANDJSWHITE;
static NSString *CSSANDJSGRAY;


+(BOOL) connectedToNetwork{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

/**
 * 将实线转换为虚线
 */
+(void) convert2DasheLine:(UIImageView *) imageView {
    
    
    CGRect viewRect=imageView.frame;
    
    UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    
    
    CGFloat lengths[] = {9,6};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor lightGrayColor].CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, 0.0);    //开始画线
    CGContextAddLineToPoint(line, 0.0, viewRect.size.height);
    CGContextStrokePath(line);
    
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
}


/**
 *将View加上圆角和投影
 */
+(void) convert2CardView:(UIView *)view withCornerRadius:(int) radius borderWidth:(float ) borderWidth{
    //UIView设置阴影
    
    CALayer *layer= [view layer];
    [layer setShadowOffset:CGSizeMake(0, 1)];
    [layer setShadowRadius:2.4];
    [layer setShadowOpacity:0.2];
    [layer setShadowColor:[UIColor colorWithWhite:0.1f alpha:0.7f].CGColor];

    //UIView设置边框
    if (radius>0) {
        [layer setCornerRadius:radius];
    }
    if (borderWidth>0) {
        [layer setBorderWidth:borderWidth];
        [layer setBorderColor:[UIColor whiteColor].CGColor];
    }    
}

+(void) addShadowView:(UIView *)view Opacity:(float) opacity{
    CALayer *layer= [view layer];
    [layer setShadowOffset:CGSizeMake(0.2, 0.8)];
    [layer setShadowRadius:2.2];
    [layer setShadowOpacity:opacity];
    [layer setShadowColor:[UIColor colorWithWhite:0.1f alpha:0.7f].CGColor];
}

+(void)addShadowView:(UIView *)view radius:(float)radius size:(CGSize)size{
    CALayer *layer= [view layer];
    [layer setShadowOffset:size];
    [layer setShadowRadius:radius];
    [layer setShadowOpacity:0.3];
    [layer setShadowColor:[UIColor blackColor].CGColor];
}

+(UIView *)getShadowView:(UIView *)view Opacity:(float)opacity{
    UIView *container = [[UIView alloc] initWithFrame:view.frame];
    
    [self addShadowView:container Opacity:opacity];
    
    CGRect tmpRect = CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
    [view setFrame:tmpRect];
    [container addSubview:view];
    
    return container;
}

+(UIView *)addGradualMagicSep:(UIView *)targetView type:(NSInteger)type{
    
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    //  创建渐变色数组，需要转换为CGColor颜色
    CGFloat alpha = type == 0?1:0;
    gradientLayer.colors = @[(__bridge id)RGBA(255, 255, 255, alpha).CGColor,(__bridge id)RGBA(255, 255, 255, 1-alpha).CGColor];
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    
    CGFloat startX = type==0?0: CGRectGetWidth(targetView.frame) -30;
    UIView *gradientView = [[UIView alloc] initWithFrame:CGRectMake(startX, CGRectGetMinY(targetView.frame), 30, CGRectGetHeight(targetView.frame))];
    gradientLayer.frame = gradientView.bounds;
    [gradientView.layer addSublayer:gradientLayer];
    
    return gradientView;
}

/**
 *将view加上圆角和边框
 */
+(void) convert2BorderView:(UIView *) view{
    view.backgroundColor=[UIColor whiteColor];
     CALayer *layer= [view layer];
    
//    
    [layer setShadowOffset:CGSizeMake(0, 1)];
    [layer setShadowRadius:1.8];
    [layer setShadowOpacity:0.1];
    [layer setShadowColor:[UIColor colorWithWhite:0.1f alpha:0.4f].CGColor];
    
    
     [layer setCornerRadius:2.5];
     [layer setBorderWidth:0.6];
     [layer setBorderColor:[UIColor colorWithWhite:0.8 alpha:1.0f].CGColor];
    
   // view.clipsToBounds=YES;
    
}

//利用正则表达式验证
+(BOOL)isvalidateEmail:(NSString*)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(BOOL)isValidateString:(NSString *)myString
{
    NSCharacterSet *nameCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"] invertedSet];
    NSRange userNameRange = [myString rangeOfCharacterFromSet:nameCharacters];
    if (userNameRange.location != NSNotFound) {
        //NSLog(@"包含特殊字符");
        return FALSE;
    }else{
        return TRUE;
    }
    
}

+ (NSString*)fileAvataPathWithID:(NSString *)ID {
	 NSString *imageCachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
     NSString *avataName=[NSString stringWithFormat:@"thumb_%@",ID];
     NSString *filePath = [imageCachePath stringByAppendingPathComponent:avataName];
     return filePath;
}

+(NSString *)getCSSandJSWhite{
    if (!CSSANDJSWHITE) {
        CSSANDJSWHITE=[NSString stringWithFormat:@"<script type=\"text/javascript\">function myResize(){var imgs = document.getElementsByTagName(\"img\");for(var i=0, len=imgs.length; i < len; i++){resizeImage(imgs[i],%f,%f);}}function resizeImage(image,width,height){var w = image.width;var h = image.height;if(w>width ){image.style.width=width;image.style.height=parseInt(h*(width/w));}if(h>height && h>w){image.style.width = parseInt(w*(height/h));image.style.height = height;}}</script><style type=\"text/css\">body{font-family: 'Lucida Grande', Arial, Helvetica, Geneva, Verdana, sans-serif;color: #727272;background-color:#ffffff}h1{margin-top:0px;margin-bottom:0px;padding-top:0px;padding-bottom:0px;font-size:17pt;color: #000000;}table {border: hidden;-webkit-border-radius: 6px;border: 1px solid #bdc3c7;margin: 0 auto;clear: both;border: 0;margin-bottom: 2em;border-collapse: collapse;}thead {text-align: left;color: #FFF;font-weight: bold;border-bottom: 1px solid #ccc;}thead td{background-color: #E74C3C ;padding: 5px;}td{border: hidden;border: 1px solid #bdc3c7;}p{font-size:11pt;}h2,h3,h4,h5,h6{margin-top:0px;margin-bottom:0px;padding-top:0px;padding-bottom:0px;font-size:14pt;}#gray{color:#959595}a:link,a:visited{color:#545454;font-weight:bold;}</style>",kDeviceWidth-22,KDeviceHeight-22];
    }
    return CSSANDJSWHITE;
}

+(NSString *)getCSSandJSGray{
    if (!CSSANDJSGRAY) {
        CSSANDJSGRAY=[NSString stringWithFormat:@"<script type=\"text/javascript\">window.onload=myResize();function myResize(){var imgs = document.getElementsByTagName(\"img\");for(var i=0, len=imgs.length; i < len; i++){resizeImage(imgs[i],%f,%f);}}function resizeImage(image,width,height){var w = image.width;var h = image.height;if(w>width && w>h){image.style.width=width;image.style.height=parseInt(h*(width/w));}if(h>height && h>w){image.style.width = parseInt(w*(height/h));image.style.height = height;}}</script><style type=\"text/css\">body{font-family: 'Lucida Grande', Arial, Helvetica, Geneva, Verdana, sans-serif;color: #727272;background-color:#ffffff}h1{margin-top:0px;margin-bottom:0px;padding-top:0px;padding-bottom:0px;font-size:17pt;color: #000000;}table {border: hidden;-webkit-border-radius: 6px;border: 1px solid #bdc3c7;margin: 0 auto;clear: both;border: 0;margin-bottom: 2em;border-collapse: collapse;}thead {text-align: left;color: #FFF;border-bottom: 1px solid #ccc;font-weight: bold;}thead td{background-color: #E74C3C ;padding: 5px;}td{border: hidden;border: 1px solid #bdc3c7;}p{font-size:11pt;}h2,h3,h4,h5,h6{margin-top:0px;margin-bottom:0px;padding-top:0px;padding-bottom:0px;font-size:14pt;}#gray{color:#959595}a:link,a:visited{color:#545454;font-weight:bold;}</style>",kDeviceWidth-22,KDeviceHeight-22];
    }
    return CSSANDJSGRAY;
}


/**
 *将日期字符串格式化
 */
+(NSString *)getFormatDate:(NSString *) originalDate{
    originalDate=[originalDate substringFromIndex:5];
    NSArray *dateArray=[originalDate componentsSeparatedByString:@" "];
    originalDate=[dateArray objectAtIndex:0];
    NSArray * times=[[dateArray objectAtIndex:1] componentsSeparatedByString:@":"];
    NSString *returnString=[NSString stringWithFormat:@"%@ %@:%@",originalDate,[times objectAtIndex:0],[times objectAtIndex:1]];
    return returnString;
}
 

/**
 *用最简短的格式显示两个日期的间隔
 */
+(NSString *)getSimpleSpanWithBegin:(NSString *) begin end:(NSString *)end isTimeExist:(bool) isTimeExist{
    NSArray *beginDateTime=[begin componentsSeparatedByString:@" "];
    NSArray *endDateTime=[end componentsSeparatedByString:@" "];
    
    NSArray *beginDateArray= [[beginDateTime objectAtIndex:0] componentsSeparatedByString:@"-"];  
    NSArray *endDateArray=[[endDateTime objectAtIndex:0] componentsSeparatedByString:@"-"];
    
    NSArray *beginTimeArray=[[beginDateTime objectAtIndex:1] componentsSeparatedByString:@":"];
    NSArray *endTimeArray=[[endDateTime objectAtIndex:1] componentsSeparatedByString:@":"];
    
    //年月日都相等
    if ([[beginDateArray objectAtIndex:0] isEqualToString:[endDateArray objectAtIndex:0]]&&[[beginDateArray objectAtIndex:1] isEqualToString:[endDateArray objectAtIndex:1]]&&[[beginDateArray objectAtIndex:2] isEqualToString:[endDateArray objectAtIndex:2]]) {
       
       return [NSString stringWithFormat:@"%@/%@ %@:%@-%@:%@",[beginDateArray objectAtIndex:1],[beginDateArray objectAtIndex:2],[beginTimeArray objectAtIndex:0],[beginTimeArray objectAtIndex:1],[endTimeArray objectAtIndex:0],[endTimeArray objectAtIndex:1]];

            
        
    }else if([[beginDateArray objectAtIndex:0] isEqualToString:[endDateArray objectAtIndex:0]]){ //只有年相等，其他任意
        if (isTimeExist) {
             return [NSString stringWithFormat:@"%@/%@ %@:%@-%@/%@ %@:%@",[beginDateArray objectAtIndex:1],[beginDateArray objectAtIndex:2],[beginTimeArray objectAtIndex:0],[beginTimeArray objectAtIndex:1],[endDateArray objectAtIndex:1],[endDateArray objectAtIndex:2],[endTimeArray objectAtIndex:0],[endTimeArray objectAtIndex:1]];
        }else{
             return [NSString stringWithFormat:@"%@/%@ -%@/%@ ",[beginDateArray objectAtIndex:1],[beginDateArray objectAtIndex:2],[endDateArray objectAtIndex:1],[endDateArray objectAtIndex:2]];
        }
        
        
        
        
    }else{ //全都不相等
        NSString *beginYear=[[beginDateArray objectAtIndex:0] substringFromIndex:2];
        NSString *endYear=[[endDateArray objectAtIndex:0] substringFromIndex:2];
        
        if (isTimeExist) {
            return [NSString stringWithFormat:@"%@/%@/%@ %@:%@-%@/%@/%@ %@:%@",beginYear,[beginDateArray objectAtIndex:1],[beginDateArray objectAtIndex:2],[beginTimeArray objectAtIndex:0],[beginTimeArray objectAtIndex:1],endYear,[endDateArray objectAtIndex:1],[endDateArray objectAtIndex:2],[endTimeArray objectAtIndex:0],[endTimeArray objectAtIndex:1]];

        }else{
            return [NSString stringWithFormat:@"%@/%@/%@ -%@/%@/%@ ",beginYear,[beginDateArray objectAtIndex:1],[beginDateArray objectAtIndex:2],endYear,[endDateArray objectAtIndex:1],[endDateArray objectAtIndex:2]];
        }
    }
    return nil;
}

+(CGSize) rectForString:(NSString *)value font:(UIFont *) font andWidth:(float) width{
    CGSize sizeToFit = [value sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit;
}

+ (float) heightForTextView: (UILabel *)label WithText: (NSString *) strText{
    CGSize constraint = CGSizeMake(label.frame.size.width , CGFLOAT_MAX);
    CGSize size = [strText sizeWithFont: label.font constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    float fHeight = size.height;
    return fHeight;
}


/**
 *缩放图片
 */
+(UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSizeWithSameAspectRatio:(CGSize)targetSize;
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor; // scale to fit height
        }
        else {
            scaleFactor = heightFactor; // scale to fit width
        }
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    CGImageRef imageRef = [sourceImage CGImage];
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
    
    if (bitmapInfo == kCGImageAlphaNone) {
        bitmapInfo = kCGImageAlphaNoneSkipLast;
    }
    
    CGContextRef bitmap;
    
    if (sourceImage.imageOrientation == UIImageOrientationUp || sourceImage.imageOrientation == UIImageOrientationDown) {
        bitmap = CGBitmapContextCreate(NULL, targetWidth, targetHeight, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
        
    } else {
        bitmap = CGBitmapContextCreate(NULL, targetHeight, targetWidth, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
        
    }
    
    // In the right or left cases, we need to switch scaledWidth and scaledHeight,
    // and also the thumbnail point
    if (sourceImage.imageOrientation == UIImageOrientationLeft) {
        thumbnailPoint = CGPointMake(thumbnailPoint.y, thumbnailPoint.x);
        CGFloat oldScaledWidth = scaledWidth;
        scaledWidth = scaledHeight;
        scaledHeight = oldScaledWidth;
        
        CGContextRotateCTM (bitmap, M_PI_2); // + 90 degrees
        CGContextTranslateCTM (bitmap, 0, -targetHeight);
        
    } else if (sourceImage.imageOrientation == UIImageOrientationRight) {
        thumbnailPoint = CGPointMake(thumbnailPoint.y, thumbnailPoint.x);
        CGFloat oldScaledWidth = scaledWidth;
        scaledWidth = scaledHeight;
        scaledHeight = oldScaledWidth;
        
        CGContextRotateCTM (bitmap, -M_PI_2); // - 90 degrees
        CGContextTranslateCTM (bitmap, -targetWidth, 0);
        
    } else if (sourceImage.imageOrientation == UIImageOrientationUp) {
        // NOTHING
    } else if (sourceImage.imageOrientation == UIImageOrientationDown) {
        CGContextTranslateCTM (bitmap, targetWidth, targetHeight);
        CGContextRotateCTM (bitmap, -M_PI); // - 180 degrees
    }
    
    CGContextDrawImage(bitmap, CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledWidth, scaledHeight), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* newImage = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return newImage;
}

/**
 * 控件飞入
 */
+(void) flyIn:(UIView *) rootView{
   NSArray *subViews= [rootView subviews];
    for (int i=0; i<subViews.count; i++) {
        UIView *item=[subViews objectAtIndex:i];
        CGRect originalFrame=item.frame;
        item.frame=CGRectMake(originalFrame.origin.x, rootView.bounds.size.height, originalFrame.size.width,originalFrame.size.height);
        item.alpha=0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( NSEC_PER_SEC/10+NSEC_PER_SEC/7*i)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.4
                                  delay:0.0f
                 usingSpringWithDamping:0.3
                  initialSpringVelocity:4
                                options:UIViewAnimationOptionAllowAnimatedContent
                             animations:^{
                                 item.frame=originalFrame;
                                 item.alpha=1;
                             }
                             completion:nil];
            
        
         });
    }
}


#pragma mark - 二维码

+ (UIImage *)generateQRCode:(NSString *) urlString size:(CGFloat) size {
    //1.实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    NSData *data =[urlString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    //2.数据滤镜图像
    CIImage *outputImage = [filter outputImage];
    
    //3.输出的图像模糊，重绘处理
    CGRect extentRect = CGRectIntegral(outputImage.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extentRect), size/CGRectGetHeight(extentRect));
    //创建bitmap
    size_t width = CGRectGetWidth(extentRect) * scale;
    size_t height = CGRectGetHeight(extentRect) * scale;
    CGColorSpaceRef spaceColor = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, spaceColor, (CGBitmapInfo) kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:outputImage fromRect:extentRect];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extentRect, bitmapImage);
    
    //4.保存处理好的image
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
}

/**
 * 随机获取颜色，用于消息列表图标背景色
 */
+ (UIColor *) getFlatUIColors{
    NSArray *candidateColors=[NSArray arrayWithObjects:@"f3a683",@"f7d794",@"778beb",@"e77f67",@"cf6a87",@"786fa6",@"f8a5c2",@"3dc1d3",@"ea8685",nil ];
    int randomIndex = arc4random()%[candidateColors count];
    UIColor *selectedColor = [HexColor colorWithHexString:candidateColors[randomIndex]];
    return selectedColor;
}

#pragma mark - textfield and textview

+(UITextView *)generateTextView:(NSString *)tipStr placeholder:(NSString *)placeholder frame:(CGRect)frame{
    
    UITextView *textView = [[UITextView alloc] init];
//    textView.placeholder = placeholder;
    [textView setBackgroundColor:[UIColor whiteColor]];
    
    textView.layer.cornerRadius = 5;
    textView.layer.masksToBounds = YES;
    textView.textAlignment=NSTextAlignmentLeft;
    textView.font=[UIFont systemFontOfSize:DefaultMainFontSize];
    textView.textColor = DefaultFontColor;
    
//    textView.placeholder = placeholder;
    
    CGFloat labelWidth = (tipStr.length +2) * DefaultMainFontSize;

    UILabel *tipLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, 40)];
    [tipLab setText:tipStr];
    [tipLab setFont:[UIFont systemFontOfSize:DefaultMainFontSize]];
    [tipLab setTextAlignment:NSTextAlignmentCenter];
    tipLab.textColor=[UIColor lightGrayColor];
    [textView addSubview:tipLab];
    
    textView.textContainerInset = UIEdgeInsetsMake(10, labelWidth-2.5, 0, 0);
    
    [textView setFrame:frame];
    
    return textView;
}

+(UITextField *)generateTextField:(NSString *)tipStr placeholder:(NSString *)placeholder frame:(CGRect)frame{
    CGFloat height = CGRectGetHeight(frame);
    
    UITextField *textField = [[UITextField alloc] init];
    textField.layer.cornerRadius = 5;
    textField.layer.masksToBounds = YES;
    [textField setBackgroundColor:[UIColor whiteColor]];
    
    textField.textAlignment=NSTextAlignmentLeft;
    textField.font=[UIFont fontWithName:FontName size:DefaultMainFontSize];
    textField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    textField.textColor = DefaultFontColor;
    
    textField.placeholder = placeholder;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    CGFloat labelWidth = (tipStr.length +2) * DefaultMainFontSize;
    
    UILabel *tipLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, height)];
    [tipLab setText:tipStr];
    [tipLab setFont:[UIFont fontWithName:FontName size:DefaultMainFontSize]];
    [tipLab setTextAlignment:NSTextAlignmentCenter];
    tipLab.textColor=[UIColor lightGrayColor];
    textField.leftView = tipLab;
    
    [textField setFrame:frame];
    
    return textField;
}

@end

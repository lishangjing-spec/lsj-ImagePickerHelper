//
//  LSJImagePickerHelper.h
//  lsj-ImagePickerHelper
//
//  Created by lishangjing on 2024/7/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ImagePickerCompletion)(UIImage *image);
typedef void (^VideoPickerCompletion)(NSURL *url);

@interface LSJImagePickerHelper : NSObject

/// 单选图片
- (void)pickImageFromViewController:(UIViewController *)controller completion:(ImagePickerCompletion)completion;

/// 单选视频
- (void)pickVideoFromViewController:(UIViewController *)controller completion:(VideoPickerCompletion )completion;

@end

NS_ASSUME_NONNULL_END

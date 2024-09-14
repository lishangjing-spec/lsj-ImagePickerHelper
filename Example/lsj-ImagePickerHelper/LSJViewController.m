//
//  LSJViewController.m
//  lsj-ImagePickerHelper
//
//  Created by 534016847@qq.com on 07/11/2024.
//  Copyright (c) 2024 534016847@qq.com. All rights reserved.
//

#import "LSJViewController.h"
#import "LSJImagePickerHelper.h"

@interface LSJViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *resultLabel;
@property (nonatomic, strong) LSJImagePickerHelper *imagePickerHelper;

@end

@implementation LSJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Init TableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
    // Init UILabel
    self.resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 40 - 100, self.view.bounds.size.width, 40)];
    self.resultLabel.textColor = [UIColor blackColor];
    self.resultLabel.font = [UIFont systemFontOfSize:12];
    self.resultLabel.textAlignment = NSTextAlignmentCenter;
    self.resultLabel.numberOfLines = 0;
    self.resultLabel.text = @"未选择";
    [self.view addSubview:self.resultLabel];
}

/// 图片选择
- (void)pickImage{
    __weak typeof(self)weakSelf = self;
    [self.imagePickerHelper pickImageFromViewController:self completion:^(UIImage *image) {
        __strong typeof(self)strongSelf = weakSelf;
        if (strongSelf) {
            self.resultLabel.text = [NSString stringWithFormat:@"图片：%@",image];
        }
    }];
}

/// 视频选择
- (void)pickVideo{
    __weak typeof(self)weakSelf = self;
    [self.imagePickerHelper pickVideoFromViewController:self completion:^(NSURL *url) {
        __strong typeof(self)strongSelf = weakSelf;
        if (strongSelf) {
            self.resultLabel.text = [NSString stringWithFormat:@"视频：%@",url];
        }
    }];
}

// MARK: - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.resultLabel.text = @"未选择";
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [self pickImage];
    } else if (indexPath.row == 1) {
        [self pickVideo];
    } else {
        _imagePickerHelper = nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"选择图片";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"选择视频";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"销毁";
    }
    
    return cell;
}

- (LSJImagePickerHelper *)imagePickerHelper{
    if (!_imagePickerHelper) {
        _imagePickerHelper = [LSJImagePickerHelper new];
    }
    return _imagePickerHelper;
}

@end

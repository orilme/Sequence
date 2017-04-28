//
//  ViewController.m
//  Sequence
//
//  Created by orilme on 2017/4/24.
//  Copyright © 2017年 orilme. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:@(6), @(1), @(2), @(5), @(10), @(9), @(4), @(3), @(7), nil];
    
    //冒泡排序
    //[self foolSortArray:arr];
    
    //选择排序
    //[self selectSortArray:arr];
    
    //快速排序
    [self quickSortArray:arr withLeftIndex:0 andRightIndex:arr.count - 1];
    NSLog(@"%@",arr);
    

    //二分查找法
    NSInteger dest = [self dichotomySearch:arr target:@(1)];
    NSLog(@"%ld", (long)dest);
    
}

#pragma mark - 冒泡排序
/**
 最好时间复杂度是O(n)
 最坏时间复杂度是O(n^2)
 平均时间复杂度：O(n^2)
 平均空间复杂度：O(1)
 */
- (void)foolSortArray:(NSMutableArray *)array {
    for (int i = 0; i < array.count - 1; i++) {
        for (int j = 0; j < array.count - i - 1; j++) {
            if (array[j] > array[j+1]) {
                id tmp = array[j];
                array[j] = array[j+1];
                array[j+1] = tmp;
            }
        }
    }
}

#pragma mark - 选择排序
/**
 最好时间复杂度是O(n)
 最坏时间复杂度是O(n^2)
 平均时间复杂度：O(n^2)
 平均空间复杂度：O(1)
 */
- (void)selectSortArray:(NSMutableArray *)array {
    for (int i=0; i<array.count-1; i++) {
        for (int j=i+1; j<array.count; j++) {
            if (array[i] > array[j]) {
                id tmp = array[i];
                array[i] = array[j];
                array[j] = tmp;
            }
        }
    }
}

#pragma mark - 快速排序
/**
 最理想情况算法时间复杂度O(nlogn)，最坏O(n^2),平均O(nlogn)
 平均空间复杂度：O(nlogn)       O(nlogn)~O(n^2)
 */
- (void)quickSortArray:(NSMutableArray *)array withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex {
    if (leftIndex >= rightIndex) {//如果数组长度为0或1时返回
        return ;
    }
    
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    NSInteger key = [array[i] integerValue];//记录比较基准数
    
    while (i < j) {
        /**** 首先从右边j开始查找比基准数小的值 ***/
        while (i < j && [array[j] integerValue] >= key) {//如果比基准数大，继续查找
            j--;
        }
        //如果比基准数小，则将查找到的小值调换到i的位置
        array[i] = array[j];
        
        /**** 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 ***/
        while (i < j && [array[i] integerValue] <= key) {//如果比基准数小，继续查找
            i++;
        }
        //如果比基准数大，则将查找到的大值调换到j的位置
        array[j] = array[i];
        
    }
    
    //将基准数放到正确位置
    array[i] = @(key);
    
    /**** 递归排序 ***/
    //排序基准数左边的
    [self quickSortArray:array withLeftIndex:leftIndex andRightIndex:i - 1];
    //排序基准数右边的
    [self quickSortArray:array withLeftIndex:i + 1 andRightIndex:rightIndex];
}

#pragma mark - 二分查找
/**
 二分查找法只适用于已经排好序的查找
 */
- (NSInteger)dichotomySearch:(NSArray *)array target:(id)key {
    NSInteger left = 0;
    NSInteger right = [array count] - 1;
    NSInteger middle = [array count] / 2;
    
    while (right >= left) {
        middle = (right + left) / 2;
        
        if (array[middle] == key) {
            return middle;
        }
        
        if (array[middle] > key) {
            right = middle - 1;
        }else if (array[middle] < key) {
            left = middle + 1;
        }
    }
    return -1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

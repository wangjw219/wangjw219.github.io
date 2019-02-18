---
title: 快速排序
date: 2019-02-18 20:09:49
tags:
- 排序算法
categories: [算法与数据结构]
---
快速排序是一种常用的排序算法，是实际排序应用中最好的选择，因为它的平均性能很好。
<!-- more -->
**1. 实现步骤**
快速排序采用了分治策略。下面是对一个典型数组进行快速排序的步骤：

1）分解：取数组中任意元素作为基准元素，将数组划分为两个（可能为空）子数组（分别称为左子数组和右子数组），使得左子数组中的每一个元素都小于等于基准元素，而右子数组中的每个元素都大于基准元素。

2）解决：递归调用快速排序，对左子数组和右子数组进行排序。

3）合并：左子数组 + 基准元素 + 右子数组 = 排序好的数组。（如果子数组都是原址排序的，则不需要合并操作）

**2. JS 实现**
```
function quickSort(arr) {
    if (arr.length < 2) return arr;
    // 选取基准元素，这里直接拿数组的第一个元素
    const basicElement = arr[0];
    let leftArr = [],
        rightArr = [];
    // 分解
    for (i = 1; i < arr.length; i++) {
        let element = arr[i];
        if (element <= basicElement) {
            leftArr.push(element);
        } else {
            rightArr.push(element);
        }
    }
    // 递归调用并且合并
    return [...quickSort(leftArr), basicElement, ...quickSort(rightArr)];
}
```
**3. 性能分析**
在理想情况下，排序 n 个项目的时间复杂度为 O(n*lgn)；在最坏情况下，排序 n 个项目的时间复杂度是 O(n<sup>2</sup>)。

1）最坏情况划分：当划分产生的两个子数组分别包含 n - 1 个元素和 0 个元素时，快速排序的最坏情况产生。

2）最好情况划分：在可能的最平衡的划分中，每次得到的两个数组大小都不大于 n / 2。
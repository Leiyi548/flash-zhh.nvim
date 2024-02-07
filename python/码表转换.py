#-*- coding : utf-8 -*-
# coding: utf-8

# 1. 先把码表复制到 excel
# 2. 再弄成 csv

import csv

output_file_01 = open('./output/虎码-output01.txt', 'w', encoding='utf-8')
output_file_02 = open('./output/虎码-output02.txt', 'w', encoding='utf-8')
# 读取 CSV 文件
with open('./asset/虎码单字词库.csv', newline='', encoding='utf-8') as csvfile:
  reader = csv.reader(csvfile)
  for row in reader:
    # 确保行至少有两个元素
    if len(row) >= 2:
        # 获取第一个和第二个元素
        first_element = row[0]
        second_element = row[1]
        if second_element == "??" or second_element == "?": continue
        if len(first_element) ==1:
          # 转换成指定格式
          transformed_row = '["{}"] = [[\\%([{}{}]\\)]],\n'.format(first_element, first_element, second_element)
          # 写入到输出文件中
          output_file_01.write(transformed_row)
        else:
          transformed_row = '["{}"] = [[\\%({}\\|[{}]\\)]],\n'.format(first_element, first_element, second_element)
          # 写入到输出文件中
          output_file_02.write(transformed_row)

output_file_01.close()
output_file_02.close()
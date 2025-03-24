clc;
clear;
close all;
%% 读取对应文件夹下的文件，进行修改得到相应的数据
FileFold_1 = fullfile('.\awesome-gins-datasets\'); %填写需要读取文件夹的路径，可以是绝对路径，也可以是相对路径
FileFold_2 = fullfile('.\BASEPROD\');
FileFold_3 = fullfile('.\NeurIT Dataset\');
FileFold_4 = fullfile('.\Opportunity\');
FileFold_5 = fullfile('.\outback\');
FileFold_6 = fullfile('.\PAMAP\');
FileFold_7 = fullfile('.\Rosario Dataset\');
FileFold_8 = fullfile('.\WISDM\WISDM_all\');

% Goal = {'acc','gyro','all'};
Goal = {'all'};  %只读取全部
Device_1 = {'ADIS16460','ADIS16465','i300','ICM20602'};   %done
Device_2 = {'output'};
Device_3 = {'NeurIT'};  %这个还有新的内部文件
Device_4 = {'1_Activity_4','2_Activity_4','3_Activity_4','4_Activity_4','5_Activity_4'};  
Device_5 = {'Fence_5FPS','Forest_5FPS'};
Device_6 = {'1_Activity_1','1_Activity_2','1_Activity_3'};  %这个数据较多，考虑一下
Device_7 = {'imu'};
Device_8 = {'phone_1_A'};  %数据也比较多

%% 读取单个文件进行显示
fileFolder = FileFold_3;  %按照需要修改对应的路径. 目前是读取当前路径下对应的单个文件
Device = Device_3; %修改前缀名称以便于修改
for Device_index = 1:length(Device)
    for Goal_index = 1:length(Goal)
         Temp_FileName = strcat(fileFolder,string(Device{Device_index})+'_'+string(Goal{Goal_index}));   %根据循环来得到对应的文件目录
         Data = readmatrix(Temp_FileName);
         figure; %按照不同的加速度、角速度分类
         for kk = 1:size(Data,2)
             subplot(3,3,kk);
             plot(Data(:,kk),'Linewidth',1.5); %画出每一列的数 
             hold on;
         end
         sgtitle(string(Device{Device_index})+ string(Goal(Goal_index))); %整体的标签
    end
end

%% 
% 获取所有Figure句柄
figHandles = findall(0, 'Type', 'figure');
% 定义目标路径并创建文件夹
targetDir = 'D:\MatlabFileWork\2025.1.15manuscript-缺失综述\2025.3.23初步处理数据集\读取后保存图片';
if ~exist(targetDir, 'dir')
    mkdir(targetDir);
end

% 批量保存为PNG
for i = 1:length(figHandles)
    fig = figHandles(i);
    filename = fullfile(targetDir, ['Figure_', num2str(i), '.png']);
    saveas(fig, filename);
    % 或使用高分辨率保存
    % print(fig, filename, '-dpng', '-r300');
end
disp('所有Figure已保存至指定文件夹！');


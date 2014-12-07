# OS X 终端指令

<!-- create time: 2014-12-07 22:13:32  -->

[Mac 常用终端命令与使用 ](http://bbs.ithome.com/thread-441231-1-1.html)

[Mac 终端命令收集](http://blog.csdn.net/ysy441088327/article/details/7890879)

###在终端中进入文件夹
    cd ~/Desktop
    如果文件夹的名称中有空格,则需要加反斜杠来标识
    cd iPhone Developer  需要写成 cd iPhone\ Developer
    cd c/c++  cd c\:c++
    
###返回上层文件夹
    cd ../
    
###显示Mac隐藏文件的命令
    defaults write com.apple.finder AppleShowAllFiles  YES
    注:默认为NO,表示不显示,命令执行后需要重新启动Finder
    
###建立新目录 ---- mkdir 
    例：在驱动目录下建一个备份目录 backup 
    mkdir /System/Library/Extensions/backup
    
###拷贝文件 ---- cp 
    例：想把桌面的Natit.kext 拷贝到驱动目录中 
    cp -R /User/用户名/Desktop/Natit.kext /System/Library/Extensions 
    参数R表示对目录进行递归操作，kext在图形界面下看起来是个文件，实际上是个文件夹。
    把驱动目录下的所有文件备份到桌面backup 
    cp -R /System/Library/Extensions/* /User/用户名/Desktop/backup

###移动文件 ---- mv 
    例：想把AppleHDA.Kext 移到桌面 
    mv /System/Library/Extensions/AppleHDA.kext /User/用户名/Desktop 
    想把AppleHDA.Kext 移到备份目录中 
    mv /System/Library/Extensions/AppleHDA.kext /System/Library/Extensions/backup 
    
###删除文件 ---- rm 
        例：想删除驱动的缓存 
        rm -rf /System/Library/Extensions.kextcache 
        rm -rf /System/Library/Extensions.mkext 
        参数－rf 表示递归和强制，千万要小心使用，如果执行了 "rm -rf /" 你的系统就全没了 

###利用 lipo 合并静态库文件
    lipo -create /Users/amarishuyi/Desktop/map/Release-iphoneos/libbaidumapapi.a/Users/amarishuyi/Desktop/map/Release-iphonesimulator/libbaidumapapi.a -output/Users/amarishuyi/Desktop/map.a
    

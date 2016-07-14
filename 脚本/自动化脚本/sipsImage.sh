#查找当前文件夹下所有png图片并转换成固定格式
#创建文件夹
mkdir imageFor4S imageFor5S imageFor6 imageFor6P
#查找所有png图片
for i in `ls *.png`
do
    sips -s format png -z 960  640  $i --out imageFor4S/"960px_"$i
    sips -s format png -z 1136 640  $i --out imageFor5S/"1136px_"$i
    sips -s format png -z 1134 750  $i --out imageFor6/"1134px_"$i
    sips -s format png -z 2208 1242 $i --out imageFor6P/"2208px_"$i
done


##＃创建SSH keys
####1. 检查SSH keys
	$ ls -al ~/.ssh
	是否存在.ssh和id_rsa.pub
####2. 创建新的SSH key
	
	$ ssh-keygen -t rsa -C "your_email@example.com"
	
####3. 拷贝SSH key 添加到远程仓库

	$ pbcopy < ~/.ssh/id_rsa.pub

####4. 测试连接

	$ ssh -T git@github.com
	
	
###使用Git
####1. 新建远程代码仓库
####2. 建立本地仓库，或者连接远程仓库

	git init
	git add README.md
	git commit -m "First commit"
	git remoto add origin <git-url>
	git push -u origin master
	
	或者
	git remoto add origin <git-url>
	git push -u origin master
	
	
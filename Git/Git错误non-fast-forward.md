# Git错误non-fast-forward

<!-- create time: 2014-12-17 16:25:01  -->
[chainyu的Git错误non-fast-forward后的冲突解决](http://blog.csdn.net/chain2012/article/details/7476493)
    
    问题（Non-fast-forward）的出现原因在于：git仓库中已经有一部分代码，所以它不允许你直接把你的代码覆盖上去。

    1，强推，即利用强覆盖方式用你本地的代码替代git仓库内的内容
    git push -f
    2，先把git的东西fetch到你本地然后merge后再push
    $ git fetch
    $ git merge
    这2句命令等价于
    $ git pull  
    这时候又出现的 [branch "master"]是需要明确(.git/config)如下的内容
    [branch "master"]
        remote = origin
        merge = refs/heads/master
    这等于告诉git2件事:
    1，当你处于master branch, 默认的remote就是origin。
    2，当你在master branch上使用git pull时，没有指定remote和branch，那么git就会采用默认的remote（也就是origin）来merge在master branch上所有的改变
    如果不想或者不会编辑config文件的话，可以在bush上输入如下命令行：
    $ git config branch.master.remote origin  
    $ git config branch.master.merge refs/heads/master  
    之后再重新git pull下。

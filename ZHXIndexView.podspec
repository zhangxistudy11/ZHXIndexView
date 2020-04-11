Pod::Spec.new do |s|

  #开源库的名字
  s.name         = "ZHXIndexView"
  #开源库当期版本
  s.version      = "0.0.1"
  #开源库概述（打开GitHub能看到的描述）
  s.summary      = "Index indicator for UICollectionView and UITableView"
  #开源库描述 （这个描述会被用来生成开源库的标签和提高被搜到，必需写在中间一行，只要在中间一行，不需要考虑缩进）
  s.description  = <<-DESC
                   Index indicators for UICollectionView and UITableView, such as city list, address book, passenger list, etc. It's simple to use.
                   DESC

  #可以是开源库的GitHub地址，也可以是你自己的网址等
  s.homepage     = "https://github.com/zhangxistudy11/ZHXIndexView"
  #我这里是参靠网上的一种写法，不会报警告，也可以直接 s.license = 'MIT'
  s.license = "MIT"
  #开源库作者
  s.author             = { "ZhangXi" => "zhangxilove2011@163.com" }
  #开源库作者的社交链接（此处我放的是微博）
  s.social_media_url   = "https://www.jianshu.com/u/c4d558e26604"

  #开源库支持的平台（暂时没考虑tvOS、OSX等）
  s.platform     = :ios
  #开源库最低支持
  s.ios.deployment_target = "8.0"

  #VIP 开源库GitHub的路径与tag值，GitHub路径后必须有.git,tag实际就是上面的版本
  s.source       = { :git => "https://github.com/zhangxistudy11/ZHXIndexView.git", :tag => s.version }

  #VIP 开源库资源文件 （我自己总结：每个文件都要有自己的路径，尤其你想目录分的比较详细的话，更具体的说明，看图对比着再说）
  s.source_files = 'ZHXIndexView/ZHXIndexView/*'


  # 是否支持arc
  s.requires_arc = true

end

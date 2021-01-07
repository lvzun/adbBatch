# adbBatch
android 多机器批量执行脚本

### 用例
```
  adbBatch test.txt install example.apk
```
### test.txt格式说明
  test.tx 内容为机器ip，一行一个，默认5555端口，如果特殊端口需要指定，例如：192.168.1.2:5556

### 使用帮助
```
andShell [IP] [option] [params...]
  IP 虚拟机IP文件，一行一个IP
  option
      reboot 重启
      install 安装
      start 启动
      stop 停止
      installAndStart 安装并启动
  params:
      reboot 无参数
      install 参数：安装文件名
      start 参数：包名/启动类名
      restart 参数1：包名 参数2：包名/启动类名
      stop 参数：包名
      installAndStart 参数1：安装文件名，参数2：包名/启动类名
      pull 参数1：虚拟机文件位置，参数2：本机保存位置，如果是文件夹会新建一个虚拟IP的子文件存放，如是文件后面会跟_IP
      push 参数1：本机文件位置，参数2：虚拟机文件位置

```

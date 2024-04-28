# RollbackTimeCalc函数 - 估算 MySQL 已取消事务的回滚时间

当你<ctrl+c>或者kill掉一个大事务时，你想知道这个事务需要多久才能回滚完，那么你可以利用RollbackTimeCalc函数得到。

- 导入函数：
```shell> mysql -uroot -p123456 < RollbackTimeCalc.sql```

- 通过show processlist得到线程ID
  
- 估算 MySQL 已取消事务的回滚时间
```mysql> select RollbackTimeCalc(ID,5);```

![image](https://github.com/hcymysql/RollbackTimeCalc/assets/19261879/d2c1f59f-a03c-48f1-81fe-2343943c3334)

如上图所示，大概需要7分6秒可以回滚完。


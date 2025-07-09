# mini-erp

小型客户订单管理系统

## 项目描述
旨在为企业提供高效的客户关系管理和订单处理解决方案。系统采用前后端分离架构，实现了客户信息管理、订单创建与跟踪、客户RFM分析（大数据分析）、文件处理等核心模块。

## 使用教程

1.  数据库：在数据库中执行sql文件夹下的sql语句（有外键约束）

2.  前端：进入ui-service文件夹，在终端中输入

    ``
    npm install
    ``

    ``
    npm run dev
    ``

3.  后端：spring-cloud启动

    配置修改：mysql、redis、nacos、minio

4.  python：fastapi启动

## 技术栈

前端使用Vue+TS，后端使用SpringCloud Alibaba + SpringBoot + OpenFeign + Gateway、MyBatis-Plus、Sa-Token、MySql、Redis、MinIO

## 项目结构

    1. ai-service：python代码实现的大数据分析模块
    2. ui-service：前端
    3. common：后端公共模块依赖
    4. api-gateway：网关微服务
    5. user-service：用户管理微服务
    6. client-sevice：客户管理微服务
    7. order-service：订单管理微服务
    8. file-service：文件管理微服务
    9. message-service：消息微服务（未实现）
    10. contract-service：合同管理微服务（未实现）

package com.baizhi.aop;

import com.alibaba.fastjson.JSONObject;
import com.baizhi.annotation.ClearRedisCache;
import com.baizhi.annotation.RedisCache;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import redis.clients.jedis.Jedis;

import java.lang.reflect.Method;

@Configuration//用于定义配置类，可替换xml配置文件，
// 被注解的类内部包含有一个或多个被@Bean注解的方法，
// 这些方法将会被AnnotationConfigApplicationContext或AnnotationConfigWebApplicationContext类进行扫描，并用于构建bean定义，初始化Spring容器。
@Aspect//作用是把当前类标识为一个切面供容器读取
public class RedisCacheAopHash {
    @Autowired
    private Jedis jedis;

    @Around("execution(* com.baizhi.service.*.selectAll*(..))")//切入点表达式
    public Object around(ProceedingJoinPoint proceedingJoinPoint) throws Throwable {
        Object target = proceedingJoinPoint.getTarget();//获取目标方法所在的 类的对象 target:com.baizhi.service.impl.BannerServiceImpl@193b3b18
        //获取目标方法 Map com.baizhi.service.impl.BannerServiceImpl.selectAll(Integer,Integer)
        MethodSignature methodSignature = (MethodSignature) proceedingJoinPoint.getSignature();
        Object[] args = proceedingJoinPoint.getArgs();//获取目标方法的参数值

        Method method = methodSignature.getMethod();//获得方法名
        boolean b = method.isAnnotationPresent(RedisCache.class);//判断方法上是否有RedisCache的注解
        if (b) {
            //目标方法上存在添加缓存的注解
            //获取响应的key值 看Redis 中是否存在该缓存
            String className = target.getClass().getName();//获取大Key 值 即namespace
            //拼接 map里的小key 值 方法名加参数
            StringBuilder sb = new StringBuilder();
            String methodName = method.getName();//获得方法名
            sb.append(methodName).append("(");
            for (int i = 0; i < args.length; i++) {
                sb.append(args[i]);
                if (i == args.length - 1) {
                    break;
                }
                sb.append(",");
            }
            sb.append(")");
            // 判断redis中是否存在对应的key
            if (jedis.hexists(className, sb.toString())) {
                //存在从缓存中获得对应key 的值
                String result = jedis.hget(className, sb.toString());
                System.out.println(111111);
                return JSONObject.parse(result);//把字符串转换为json 返回

            } else {
                //即缓存中不存在 放行方法冲数据库中查询 并把结果添加到缓存中去
                Object result = proceedingJoinPoint.proceed();
                jedis.hset(className, sb.toString(), JSONObject.toJSONString(result));
                return result;
            }

        } else {
            //不存在添加缓存的注解，直接放行数据库查找 并把结果返回
            Object result = proceedingJoinPoint.proceed();
            return result;
        }
    }
    //后置通知方法 经过增删改是 清空缓存

    //@After:无论目标方法是否有异常，都将执行切面中的代码（删除缓存）
    //@AfterReturning:目标方法一旦有异常，则不会执行切面中的代码（删除缓存）
    @AfterReturning("execution(* com.baizhi.service.*.*(..)) && !execution(* com.baizhi.service.*.selectAll(..))")
    public void after(JoinPoint joinPoint) {
        Object target = joinPoint.getTarget();
        MethodSignature methodSignature = (MethodSignature) joinPoint.getSignature();
        Method method = methodSignature.getMethod();
        String className = target.getClass().getName();
        if (method.isAnnotationPresent(ClearRedisCache.class)) {
            jedis.del(className);//根据大key值 直接清空下面所有的map
            System.out.println(className);
            System.out.println(222222);
        }
    }
}

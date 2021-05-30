package com.simple.testjenkins.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 项目: test-jenkins
 * <p>
 * 功能描述:
 *
 * @author: WuChengXing
 * @create: 2021-05-22 13:04
 **/
@RestController
public class HelloController {

    @GetMapping("/sayHello")
    public String sayHello() {
        return "Hello jenkins--测试改变代码部署";
    }

}

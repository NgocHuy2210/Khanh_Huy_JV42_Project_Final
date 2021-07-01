/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.huyapp.jv42_nguyenngochuy_final_project.controller;

import com.huyapp.jv42_nguyenngochuy_final_project.utils.SecurityUtils;
import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeController {

    //    public String welcomePage(Model model) {
    @RequestMapping(value = {"/"}, method = RequestMethod.GET)
    public String welcomePage() {
        List<String> roles = SecurityUtils.getRolesOfUser();
        if (!CollectionUtils.isEmpty(roles) && roles.contains("ROLE_ADMIN")) {
//            model.addAttribute("message", "This is admin welcome page!");
            return "redirect:/admin/index";
        } else if (!CollectionUtils.isEmpty(roles) && roles.contains("ROLE_RECEPTIONIST")) {
//            model.addAttribute("message", "This is receptionist welcome page!");
            return "redirect:/receptionist/index";
        } else if (!CollectionUtils.isEmpty(roles) && roles.contains("ROLE_MANAGER")) {
//            model.addAttribute("message", "This is manager welcome page!");
            return "redirect:/manager/index";
        }
        return "redirect:/login";
    }

    @RequestMapping("/login")
    public String loginPage(Model model, @RequestParam(value = "error", required = false) boolean error) {
        if (error) {
            model.addAttribute("message", "Login Fail!!!");
        }
        return "login";
    }
    
    @RequestMapping("/register")
    public String registerPage(Model model, @RequestParam(value = "error", required = false) boolean error) {
        if (error) {
            model.addAttribute("message", "Register Fail!!!");
        }
        return "register";
    }
    
    @RequestMapping("/forgot-password")
    public String forgorPasswordPage(Model model, @RequestParam(value = "error", required = false) boolean error) {
        if (error) {
            model.addAttribute("message", "Fail!!!");
        }
        return "forgot-password";
    }

//    @RequestMapping("/403")
//    public String accessDenied(Model model) {
//        return "403Page";
//    }
}

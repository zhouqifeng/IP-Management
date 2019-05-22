package com.qf.admin.web;

import com.alibaba.fastjson.JSONObject;
import com.qf.admin.pojo.dto.PageInfo;
import com.qf.admin.pojo.dto.Result;
import com.qf.admin.pojo.dto.ResultTable;
import com.qf.admin.pojo.po.Admin;
import com.qf.admin.pojo.po.Bulletin;
import com.qf.admin.pojo.po.Departname;
import com.qf.admin.pojo.po.Ipconfig;
import com.qf.admin.pojo.vo.*;
import com.qf.admin.service.AdminService;
import com.sun.istack.internal.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Date;

@Controller
public class AdminAction {

    @Autowired
    private AdminService adminService;

    @ResponseBody
    @RequestMapping("/Adminlogin")
    public String login(@RequestBody Admin admin,HttpSession session) {

        AdminDepart user = adminService.finduser(admin);
        if(user != null){
            session.setAttribute("user",user);
            session.setMaxInactiveInterval(15*60);
            return "ok";
        }
        return "error";
    }

    @RequestMapping("/")
    public String login(){

        return "/login";
    }

    @RequestMapping("/login")
    public String login2(){

        return "/login";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session){

        session.removeAttribute("user");
        return "redirect:/login";
    }

    @GetMapping("/index")
    public String index(HttpSession session, Model model) {

        if(session.getAttribute("user") == null){
            return "redirect:/login";
        }
        List<String> notes = adminService.findNotes();
        model.addAttribute("notes",notes);
        List<Departname> departs = adminService.findDeparts();
        session.setAttribute("departs",departs);
        return "index";
    }

    @GetMapping("/pages/welcome")
    public String welcome(HttpSession session,Model model,AdminQuery query) {

        AdminDepart user = (AdminDepart) session.getAttribute("user");
        if(user == null){
            return "redirect:/login";
        }
        if(user.getIsadmin() == 0){
            query.setNum(user.getOskey());
        }
        List<String> ips = adminService.findIps(query);
        model.addAttribute("ips",ips);
        return "/pages/welcome";
    }

    @GetMapping("/pages/member/indexlistdepart")
    public String indexlistdepart(HttpSession session,Model model,String departid) {

        if(session.getAttribute("user") == null){
            return "redirect:/login";
        }
        model.addAttribute("departid",departid);
        return "/pages/member/indexlistdepart";
    }

    @GetMapping("/pages/member/indexlistip")
    public String indexlistip(HttpSession session,Model model,String ip) {

        if(session.getAttribute("user") == null){
            return "redirect:/login";
        }
        List<HashMap<String,Object>> list = adminService.searchColor(ip);

        List<HashMap<String,Object>> listDepart = adminService.searchColorDepart(ip);

        model.addAttribute("ip",ip);
        model.addAttribute("list",list);
        model.addAttribute("listDepart",listDepart);
        return "/pages/member/indexlistip";
    }

    @ResponseBody
    @RequestMapping("/indexdepart")
    public Result<Ip> indexdepart(PageInfo pageInfo,String departid) {

        return adminService.indexfinddepart(pageInfo,departid);
    }

    @ResponseBody
    @RequestMapping("/indexip")
    public Result<Ip> indexip(HttpSession session,PageInfo pageInfo,String ip,AdminQuery query) {
        AdminDepart user = (AdminDepart) session.getAttribute("user");
        if(user.getIsadmin() == 0){
            query.setNum(user.getOskey());
        }
        return adminService.indexfindip(pageInfo,ip,query);
    }

    @GetMapping("/{path}")
    public String index1(@PathVariable String path, HttpSession session) {

        if(session.getAttribute("user") == null){
            return "redirect:/login";
        }
        return path;
    }

    @GetMapping("/pages/{path}")
    public String index2(@PathVariable String path, HttpSession session) {

        if(session.getAttribute("user") == null){
            return "redirect:/login";
        }
        return "pages/" + path;
    }

    @GetMapping("/pages/{path1}/{path2}")
    public String index3(HttpSession session, @PathVariable String path1, @PathVariable String path2) {

        if(session.getAttribute("user") == null){
            return "redirect:/login";
        }
        return "pages/" + path1 + "/" + path2;
    }

    @RequestMapping("/pages/member/print")
    public String print(HttpSession session, Model model) {

        if(session.getAttribute("user") == null){
            return "redirect:/login";
        }
        List<Departname> departs = adminService.findDeparts();
        model.addAttribute("departs",departs);
        return "pages/member/print";
    }

    @RequestMapping("/pages/member/printIpTable")
    public String printIpTable(HttpSession session, Model model,String departid) {

        if(session.getAttribute("user") == null){
            return "redirect:/login";
        }
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
        SimpleDateFormat df2 = new SimpleDateFormat("yyyy");
        ResultTable<List<Ip>> ipTable = adminService.printIpTable(departid);
        ipTable.setTime(df.format(new Date()));
        ipTable.setYear(df2.format(new Date()));
        model.addAttribute("ipTable",ipTable);
        return "pages/member/printIpTable";
    }

    @RequestMapping("/pages/member/findlist")
    public String findlist(HttpSession session,Model model) {

        if(session.getAttribute("user") == null){
            return "redirect:/login";
        }

        return "pages/member/findlist";
    }

    @GetMapping("/add")
    public String add(HttpSession session,Model model) {

        if(session.getAttribute("user") == null){
            return "redirect:/login";
        }

        return "add";
    }


    @ResponseBody
    @PostMapping(value = "/searchIp")
    public Map searchIp(@RequestParam("ip") String ip,@RequestParam("id") String id) {

        Map<String,String> map = new HashMap<>();
        try {

            String iproot = adminService.searchAdminIp(ip,id);

            if(iproot != null || "全部".equals(iproot)){
                Ipconfig ipconfig = adminService.searchIp(ip);
                if(ipconfig != null){
                    map.put("status","1");
                    return map;
                }else{
                    map.put("status","0");
                    return map;
                }
            }else{
                map.put("status","2");
                return map;
            }

        } catch (Exception e) {
            e.printStackTrace();
            map.put("ip","-1");
            return map;
        }
    }

    @ResponseBody
    @PostMapping(value = "/searchUsername")
    public Map searchUsername(@RequestParam("username") String username) {

        Map<String,String> map = new HashMap<>();
        try {
            Admin admin = adminService.searchUsername(username);
            if(admin != null){
                map.put("username","1");
                return map;
            }else{
                map.put("username","0");
                return map;
            }

        } catch (Exception e) {
            e.printStackTrace();
            map.put("username","-1");
            return map;
        }
    }

    @ResponseBody
    @PostMapping(value = "/addIp",produces = "application/json;charset=UTF-8")
    public int addIp(@RequestBody Ipconfig ipconfig) {

        String str = ipconfig.getIp();
        ipconfig.setIprange(str.substring(0,str.lastIndexOf('.')));

        try {
            return adminService.addIp(ipconfig);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @ResponseBody
    @RequestMapping(value = "/Admin")
    public Result<AdminDepart> showAdmins(HttpSession session,PageInfo pageInfo, AdminQuery query) {

        AdminDepart user = (AdminDepart) session.getAttribute("user");
        if(user.getIsadmin() == 0){
            query.setNum(user.getOskey());
        }
        return adminService.showAdmin(pageInfo,query);
    }

    @ResponseBody
    @RequestMapping(value = "/find")
    public Result<Ip> find(PageInfo pageInfo,Search search) {

        return adminService.find(pageInfo,search);
    }

    @ResponseBody
    @RequestMapping(value = "/departname")
    public Result<Departname> showDeparts(HttpSession session,PageInfo pageInfo, AdminQuery query) {

        AdminDepart user = (AdminDepart) session.getAttribute("user");
        if(user.getIsadmin() == 0){
            query.setNum(user.getOskey());
        }
        return adminService.showDeparts(pageInfo,query);
    }

    @ResponseBody
    @RequestMapping(value = "/note")
    public Result<Bulletin> showBulletins(PageInfo pageInfo, AdminQuery query) {

        return adminService.showBulletins(pageInfo,query);
    }

    @ResponseBody
    @PostMapping(value = "/addDepartname")
    public int addDepartname(HttpSession session, @RequestParam("departname") String departname, @RequestParam("color") String color) {
        AdminDepart user = (AdminDepart) session.getAttribute("user");
        try {
            Departname depart = adminService.searchDepartname(departname);
            List<String> col = adminService.searchDepartColor(color);
            if(depart == null && col.isEmpty()){
                int i = adminService.addDepartname(departname,color,user.getUsername());
                List<Departname> departs = adminService.findDeparts();
                session.setAttribute("departs",departs);
                return i;
            }

            if(col.size() != 0){
                return 3;
            }

            return 2;

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @ResponseBody
    @PostMapping("/delDepartname")
    public int delDepartname(HttpSession session, @RequestParam("id") Long id){

        try {
            int i = adminService.delDepartname(id);
            List<Departname> departs = adminService.findDeparts();
            session.setAttribute("departs",departs);
            return i;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    @ResponseBody
    @PostMapping("/modifyDepartname")
    public int modifyDepartname(HttpSession session, @RequestParam("id") Long id,@RequestParam("newName") String name){
        AdminDepart user = (AdminDepart) session.getAttribute("user");
        Departname depart = adminService.searchDepartname(name);
        try {
            if(depart == null){
                int i = adminService.modifyDepartname(id,name,user.getUsername());
                List<Departname> departs = adminService.findDeparts();
                session.setAttribute("departs",departs);
                return i;
            }
            return 2;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @ResponseBody
    @PostMapping("/modifyDepartColor")
    public int modifyDepartColor(HttpSession session, @RequestParam("id") Long id,@RequestParam("newColor") String color){
        AdminDepart user = (AdminDepart) session.getAttribute("user");
        List<String> col = adminService.searchDepartColor(color);
        try {
            if(col.isEmpty()){
                int i = adminService.modifyDepartColor(id,color,user.getUsername());
                List<Departname> departs = adminService.findDeparts();
                session.setAttribute("departs",departs);
                return i;
            }
            return 2;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @ResponseBody
    @RequestMapping(value = "/addAdmin",method = RequestMethod.POST,produces = "application/json;charset=UTF-8")
    public int addAdmin(@RequestBody AdminAdd adminadd) {

        Admin admin = new Admin();
        admin.setUsername(adminadd.getUsername());
        admin.setPasswd(adminadd.getPasswd());
        admin.setOskey(adminadd.getOskey());
        admin.setIsadmin(adminadd.getIsadmin());
        admin.setCreater(adminadd.getCreater());
        admin.setIprange(adminadd.getIprange()+adminadd.getIpstart()+" - "+adminadd.getIprange()+adminadd.getIpend());

        int i = Integer.parseInt(adminadd.getIpstart());
        int j = Integer.parseInt(adminadd.getIpend());
        StringBuilder stringBuilder = new StringBuilder();

        for(int ip = i; ip <= j; ip++){
            stringBuilder.append(adminadd.getIprange()+ip+',');
        }

        admin.setIps(stringBuilder.toString());

        try {

            return adminService.addAdmin(admin);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @GetMapping("/pages/member/addiprange")
    public String addiprange(HttpSession session,Model model,@RequestParam("id") int id) {

        if(session.getAttribute("user") == null){
            return "redirect:/login";
        }
        model.addAttribute("id",id);
        return "/pages/member/addiprange";
    }

    @ResponseBody
    @RequestMapping(value = "/modifyiprange",method = RequestMethod.POST,produces = "application/json;charset=UTF-8")
    public int modifyiprange(@RequestBody AdminAdd adminadd) {

        Admin admin = adminService.searchAdmin(adminadd.getId());
        if("".equals(admin.getIprange().trim())){
            admin.setIprange(adminadd.getIprange()+adminadd.getIpstart()+" - "+adminadd.getIprange()+adminadd.getIpend());
        }else{
            admin.setIprange(admin.getIprange() + " , " + adminadd.getIprange()+adminadd.getIpstart()+" - "+adminadd.getIprange()+adminadd.getIpend());
        }
        int i = Integer.parseInt(adminadd.getIpstart());
        int j = Integer.parseInt(adminadd.getIpend());
        StringBuilder stringBuilder = new StringBuilder(admin.getIps());

        for(int ip = i; ip <= j; ip++){
            stringBuilder.append(adminadd.getIprange()+ip+',');
        }

        admin.setIps(stringBuilder.toString());

        try {

            return adminService.modifyIprange(admin);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @ResponseBody
    @PostMapping("/delAdmin")
    public int delAdmin(@RequestParam("ids[]") List<Long> ids){

        try {
            return adminService.delAdmin(ids);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @ResponseBody
    @RequestMapping(value = "/addNote",method = RequestMethod.POST,produces = "application/json;charset=UTF-8")
    public int addNote(@RequestBody Bulletin Bulletin) {

        try {
            return adminService.addBulletin(Bulletin);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @ResponseBody
    @PostMapping("/delNote")
    public int delNote(@RequestParam("ids[]") List<Long> ids){

        try {
            return adminService.delNote(ids);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @ResponseBody
    @PostMapping("/modifyNote")
    public int modifyBulletin(@RequestParam("id") Long id,@RequestParam("newNote") String note){

        return adminService.modifyNote(id,note);
    }

    @ResponseBody
    @PostMapping("/modifyBulletin")
    public int modifyBulletin(@RequestParam("id") Long id,@RequestParam("status") int status){

        return adminService.modifyBulletin(id,status);
    }

    @ResponseBody
    @PostMapping("/modifyIpconfig")
    public int modifyIpconfig(@RequestParam("id") Long id,@RequestParam("field") String field,@RequestParam("value") String value){

        return adminService.modifyIp(id,field,value);
    }

    @ResponseBody
    @PostMapping("/deleteIpconfig")
    public int deleteIpconfig(HttpSession session, @RequestParam("id") Long id){

        int i = adminService.deleteIpconfig(id);
        List<Departname> departs = adminService.findDeparts();
        session.setAttribute("departs",departs);

        return i;
    }

    @ResponseBody
    @PostMapping("/delIPs")
    public int delIPs(@RequestParam("id") Long id){

        try {
            return adminService.delIPs(id);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @ResponseBody
    @PostMapping("/modifyAdmin")
    public int modifyAdmin(HttpSession session, @RequestParam("id") Long id, @RequestParam("newpasswd") String newpasswd){

        AdminDepart admin = (AdminDepart) session.getAttribute("user");

        if( admin.getId() == id){
            return adminService.modifyAdmin(id,newpasswd);
        }else{
            return 0;
        }
    }

    @GetMapping("/showIp")
    public String showIp(HttpSession session, Model model, @RequestParam("ip") String ip){

        if(session.getAttribute("user") == null){
            return "redirect:/login";
        }

        Ip showIp = adminService.showIp(ip);
        model.addAttribute("showIp" , showIp);

        return "showIp";
    }

    @GetMapping("/showIpFind")
    public String showIpFind(HttpSession session, Model model, @RequestParam("ip") String ip){

        if(session.getAttribute("user") == null){
            return "redirect:/login";
        }

        Ip showIp = adminService.showIp(ip);
        model.addAttribute("showIp" , showIp);

        return "showIpFind";
    }

    @ResponseBody
    @PostMapping("/editIp")
    public int editIp(@RequestBody Ipconfig ipconfig){

        String str = ipconfig.getIp();
        ipconfig.setIprange(str.substring(0,str.lastIndexOf('.')));

        return adminService.editIp(ipconfig);
    }

}

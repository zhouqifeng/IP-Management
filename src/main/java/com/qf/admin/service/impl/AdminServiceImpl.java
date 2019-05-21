package com.qf.admin.service.impl;

import com.qf.admin.mapper.AdminMapper;
import com.qf.admin.pojo.dto.PageInfo;
import com.qf.admin.pojo.dto.Result;
import com.qf.admin.pojo.dto.ResultTable;
import com.qf.admin.pojo.po.Admin;
import com.qf.admin.pojo.po.Bulletin;
import com.qf.admin.pojo.po.Departname;
import com.qf.admin.pojo.po.Ipconfig;
import com.qf.admin.pojo.vo.*;
import com.qf.admin.service.AdminService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {

    //要使用接口，不需要使用具体实现（log4j logback）
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private AdminMapper mapper;

    @Override
    public Result<AdminDepart> showAdmin(PageInfo pageInfo, AdminQuery query){

        Result<AdminDepart> result = new Result<AdminDepart>();

        //查询成功的情况
        result.setCode(0);
        result.setMsg("success");
        try {
            long count = mapper.countItems(query);
            result.setCount(count);
            List<AdminDepart> data = mapper.showAdmin(pageInfo,query);
            result.setData(data);
        } catch (Exception e) {
            //查询发生异常时的情况
            result.setCode(1);
            result.setMsg("failed");
            //查询发生异常时将进行日志输出(输出到控制台还是到日志文件,由logback.xml决定)
            logger.error(e.getMessage(), e);
        }
        return result;
    }

    @Override
    public Result<Departname> showDeparts(PageInfo pageInfo, AdminQuery query) {

        Result<Departname> result = new Result<Departname>();

        //查询成功的情况
        result.setCode(0);
        result.setMsg("success");
        try {
            long count = mapper.countDepart(query);
            result.setCount(count);
            List<Departname> data = mapper.showDeparts(pageInfo,query);
            result.setData(data);
        } catch (Exception e) {
            //查询发生异常时的情况
            result.setCode(1);
            result.setMsg("failed");
            //查询发生异常时将进行日志输出(输出到控制台还是到日志文件,由logback.xml决定)
            logger.error(e.getMessage(), e);
        }
        return result;
    }

    @Override
    public Result<Bulletin> showBulletins(PageInfo pageInfo, AdminQuery query) {

        Result<Bulletin> result = new Result<Bulletin>();

        //查询成功的情况
        result.setCode(0);
        result.setMsg("success");
        try {
            long count = mapper.countBulletin(query);
            result.setCount(count);
            List<Bulletin> data = mapper.showBulletins(pageInfo,query);
            System.out.println(data);
            result.setData(data);
        } catch (Exception e) {
            //查询发生异常时的情况
            result.setCode(1);
            result.setMsg("failed");
            //查询发生异常时将进行日志输出(输出到控制台还是到日志文件,由logback.xml决定)
            logger.error(e.getMessage(), e);
        }
        return result;
    }

    @Override
    public int addAdmin(Admin admin) {

       return mapper.addAdmin(admin);
    }

    @Override
    public int delAdmin(List<Long> ids) {

        Boolean flag = false;

        for(int i= 0;i<ids.size();i++){

            if(ids.get(i) != 1){
                mapper.delAdmin(ids.get(i));
            }else{
                flag = true;
            }
        }

        if(flag == true ){
            return -1;
        }

        return ids.size();
    }

    @Override
    public int addDepartname(String departname, String username) {
        return mapper.addDepartname(departname,username);
    }

    @Override
    public int delDepartname(Long id) {

        PageInfo pageinfo = new PageInfo();
        pageinfo.setPage(1);
        pageinfo.setLimit(200);
        List<Ip> list = mapper.findIndexDepart(pageinfo,id.toString());
        if(list.size() == 0){
            mapper.delDepartname(id);
            mapper.delDepartnameAdmin(id);
            return 1;
        }
        return 0;
    }

    @Override
    public int modifyDepartname(Long id, String name,String username) {
        return mapper.modifyDepartname(id,name,username);
    }

    @Override
    public int addBulletin(Bulletin bulletin) {
        return mapper.addBulletin(bulletin);
    }

    @Override
    public int delNote(List<Long> ids) {

        for(int i= 0;i<ids.size();i++){
            mapper.delNote(ids.get(i));
        }
        return ids.size();
    }

    @Override
    public int modifyNote(Long id, String note) {
        return mapper.modifyNote(id,note);
    }

    @Override
    public int modifyBulletin(Long id, int status) {
        return mapper.modifyBulletin(id,status);
    }

    @Override
    public List<Departname> findDeparts() {
        return mapper.findDeparts();
    }

    @Override
    public List<String> findNotes() {
        return mapper.findNotes();
    }

    @Override
    public Result<Ip> find(PageInfo pageInfo, Search search) {

        Result<Ip> result = new Result<Ip>();
        //查询成功的情况
        result.setCode(0);
        result.setMsg("success");
        try {
            long count = mapper.countFind(search);
            result.setCount(count);
            List<Ip> data = mapper.find(pageInfo,search);
            result.setData(data);
        } catch (Exception e) {
            //查询发生异常时的情况
            result.setCode(1);
            result.setMsg("failed");
            //查询发生异常时将进行日志输出(输出到控制台还是到日志文件,由logback.xml决定)
            logger.error(e.getMessage(), e);
        }
        return result;
    }

    @Override
    public int addIp(Ipconfig ipconfig) {
        return mapper.addIp(ipconfig);
    }

    @Override
    public List<String> findIps(AdminQuery query) {
        return mapper.findIps(query);
    }

    @Override
    public Result<Ip> indexfinddepart(PageInfo pageInfo,String departid) {
        Result<Ip> result = new Result<Ip>();
        //查询成功的情况
        result.setCode(0);
        result.setMsg("success");
        try {
            long count = mapper.countFindIndexDepart(departid);
            result.setCount(count);
            List<Ip> data = mapper.findIndexDepart(pageInfo,departid);
            result.setData(data);
        } catch (Exception e) {
            //查询发生异常时的情况
            result.setCode(1);
            result.setMsg("failed");
            //查询发生异常时将进行日志输出(输出到控制台还是到日志文件,由logback.xml决定)
            logger.error(e.getMessage(), e);
        }
        return result;
    }

    @Override
    public Result<Ip> indexfindip(PageInfo pageInfo, String ip,AdminQuery query) {
        Result<Ip> result = new Result<>();
        //查询成功的情况
        result.setCode(0);
        result.setMsg("success");
        try {
            long count = mapper.countFindIndexIp(ip,query);
            result.setCount(count);
            List<Ip> data = mapper.findIndexIp(pageInfo,ip,query);
            result.setData(data);
        } catch (Exception e) {
            //查询发生异常时的情况
            result.setCode(1);
            result.setMsg("failed");
            //查询发生异常时将进行日志输出(输出到控制台还是到日志文件,由logback.xml决定)
            logger.error(e.getMessage(), e);
        }
        return result;
    }

    @Override
    public AdminDepart finduser(Admin admin) {

        return mapper.finduser(admin);
    }

    @Override
    public int modifyIp(Long id, String field, String value) {

        return mapper.modifyIp(id,field,value);
    }

    @Override
    public int deleteIpconfig(Long id) {
        return mapper.deleteIpconfig(id);
    }

    @Override
    public Ipconfig searchIp(String ip) {

        return mapper.searchIp(ip);
    }

    @Override
    public Departname searchDepartname(String departname) {

        return mapper.searchDepartname(departname);
    }

    @Override
    public Admin searchUsername(String username) {

        return mapper.searchUsername(username);
    }

    @Override
    public int delIPs(Long id) {
        return mapper.delIPs(id);
    }

    @Override
    public Admin searchAdmin(int id) {
        return mapper.searchAdmin(id);
    }

    @Override
    public int modifyIprange(Admin admin) {
        return mapper.modifyIprange(admin);
    }

    @Override
    public String searchAdminIp(String ip, String id) {
        return mapper.searchAdminIp(ip,id);
    }

    @Override
    public int modifyAdmin(Long id, String newpasswd) {
        return mapper.modifyAdmin(id,newpasswd);
    }

    @Override
    public List<HashMap<String,Object>> searchColor(String ip) {

        List<HashMap<String,Object>> list = new ArrayList<>();

        for(int i = 1;i<256;i++){
            HashMap<String,Object> map = new HashMap<>();
            map.put("ip",i);
            map.put("color","#F0F0F0");
            list.add(map);
        }

        List<IpColor> color = mapper.searchColor(ip);

        for (IpColor c : color) {

            int a = Integer.parseInt(c.getIp().substring(c.getIp().lastIndexOf(".")+1));

            list.get(a-1).put("color",c.getColor());

            list.get(a-1).put("departid",c.getDepartid());

        }

        return list;
    }

    @Override
    public List<HashMap<String, Object>> searchColorDepart(String ip) {

        List<HashMap<String,Object>> list = new ArrayList<>();

        List<Departname> colorDepartList = mapper.searchColorDepart(ip);

        for (Departname c : colorDepartList) {

            HashMap<String,Object> map = new HashMap<>();
            map.put("departname",c.getDepartname());
            map.put("color",c.getColor());
            list.add(map);

        }

        return list;
    }

    @Override
    public Ip showIp(String ip) {
        return mapper.showIp(ip);
    }

    @Override
    public int editIp(Ipconfig ipconfig) {
        return mapper.editIp(ipconfig);
    }

    @Override
    public ResultTable<List<Ip>> printIpTable(String departid) {
        ResultTable<List<Ip>> result = new ResultTable<>();

        long count = mapper.countFindIndexDepart(departid);
        result.setCount(count);
        List<List<Ip>> data = new ArrayList<>();

        result.setPages((count-1)/20+1);
        for(int i=1;i<=(count-1)/20+1;i++){
            PageInfo pageinfo = new PageInfo();
            pageinfo.setPage(i);
            pageinfo.setLimit(20);
            List<Ip> ip20 = mapper.findIndexDepart(pageinfo,departid);
            data.add(ip20);
        }

        result.setData(data);

        return result;
    }
}

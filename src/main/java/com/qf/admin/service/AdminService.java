package com.qf.admin.service;

import com.qf.admin.pojo.dto.PageInfo;
import com.qf.admin.pojo.dto.Result;
import com.qf.admin.pojo.dto.ResultTable;
import com.qf.admin.pojo.po.Admin;
import com.qf.admin.pojo.po.Bulletin;
import com.qf.admin.pojo.po.Departname;
import com.qf.admin.pojo.po.Ipconfig;
import com.qf.admin.pojo.vo.AdminDepart;
import com.qf.admin.pojo.vo.AdminQuery;
import com.qf.admin.pojo.vo.Ip;
import com.qf.admin.pojo.vo.Search;

import java.util.HashMap;
import java.util.List;


public interface AdminService {

    Result<AdminDepart> showAdmin(PageInfo pageInfo, AdminQuery query);

    int addAdmin(Admin admin);

    int delAdmin(List<Long> ids);

    Result<Departname> showDeparts(PageInfo pageInfo, AdminQuery query);

    int modifyDepartname(Long id, String name,String username);

    int addDepartname(String departname,String username);

    int delDepartname(Long id);

    Result<Bulletin> showBulletins(PageInfo pageInfo, AdminQuery query);

    int addBulletin(Bulletin bulletin);

    int delNote(List<Long> ids);

    int modifyNote(Long id, String note);

    int modifyBulletin(Long id, int status);

    List<Departname> findDeparts();

    List<String> findNotes();

    Result<Ip> find(PageInfo pageInfo, Search search);

    int addIp(Ipconfig ipconfig);

    List<String> findIps(AdminQuery query);

    Result<Ip> indexfinddepart(PageInfo pageInfo,String departid);

    Result<Ip> indexfindip(PageInfo pageInfo, String ip,AdminQuery query);

    AdminDepart finduser(Admin admin);

    int modifyIp(Long id, String field, String value);

    Ipconfig searchIp(String ip);

    Departname searchDepartname(String departname);

    Admin searchUsername(String username);

    int delIPs(Long id);

    Admin searchAdmin(int id);

    int modifyIprange(Admin admin);

    String searchAdminIp(String ip, String id);

    int modifyAdmin(Long id, String newpasswd);

    List<HashMap<String,Object>> searchColor(String ip);

    List<HashMap<String,Object>> searchColorDepart(String ip);

    Ip showIp(String ip);

    int editIp(Ipconfig ipconfig);

    ResultTable<List<Ip>> printIpTable(String departid);

    int deleteIpconfig(Long id);
}

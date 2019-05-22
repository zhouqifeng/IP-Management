package com.qf.admin.mapper;

import com.qf.admin.pojo.dto.PageInfo;
import com.qf.admin.pojo.po.Admin;
import com.qf.admin.pojo.po.Bulletin;
import com.qf.admin.pojo.po.Departname;
import com.qf.admin.pojo.po.Ipconfig;
import com.qf.admin.pojo.vo.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminMapper {

    long countItems(@Param("query") AdminQuery query);

    List<AdminDepart> showAdmin(@Param("pageInfo") PageInfo pageInfo, @Param("query") AdminQuery query);

    int addAdmin(@Param("admin") Admin admin);

    int delAdmin(@Param("id") long id);

    long countDepart(@Param("query") AdminQuery query);

    List<Departname> showDeparts(@Param("pageInfo") PageInfo pageInfo, @Param("query") AdminQuery query);

    int modifyDepartname(@Param("id") Long id, @Param("name") String name, @Param("username") String username);

    int modifyDepartColor(@Param("id") Long id, @Param("color") String color, @Param("username") String username);

    int addDepartname(@Param("departname") String departname, @Param("color") String color, @Param("username") String username);

    int delDepartname(@Param("id") Long id);

    int delDepartnameAdmin(@Param("id") Long aLong);

    int delDepartnameIpconfig(@Param("id") Long aLong);

    long countBulletin(@Param("query") AdminQuery query);

    List<Bulletin> showBulletins(@Param("pageInfo") PageInfo pageInfo, @Param("query") AdminQuery query);

    int addBulletin(@Param("bulletin") Bulletin bulletin);

    int delNote(@Param("id") Long id);

    int modifyNote(@Param("id") Long id,@Param("note")  String note);

    int modifyBulletin(@Param("id") Long id,@Param("status") int status);

    List<Departname> findDeparts();

    List<String> findNotes();

    List<Ip> find(@Param("pageInfo") PageInfo pageInfo, @Param("search") Search search);

    long countFind(@Param("search") Search search);

    int addIp(@Param("ipconfig") Ipconfig ipconfig);

    List<String> findIps(@Param("query") AdminQuery query);

    long countFindIndexDepart(@Param("departid") String departid);

    List<Ip> findIndexDepart(@Param("pageInfo") PageInfo pageInfo,@Param("departid") String departid);

    long countFindIndexIp(@Param("ip") String ip,@Param("query") AdminQuery query);

    List<Ip> findIndexIp(@Param("pageInfo") PageInfo pageInfo,@Param("ip") String ip,@Param("query") AdminQuery query);

    AdminDepart finduser(@Param("admin") Admin admin);

    int modifyIp(@Param("id") Long id, @Param("field") String field, @Param("value") String value);

    int deleteIpconfig(@Param("id") Long id);

    Ipconfig searchIp(@Param("ip") String ip);

    Departname searchDepartname(@Param("departname") String departname);

    List<String> searchDepartColor(@Param("color") String color);

    Admin searchUsername(@Param("username") String username);

    int delIPs(@Param("id") Long id);

    Admin searchAdmin(@Param("id") int id);

    int modifyIprange(@Param("admin") Admin admin);

    String searchAdminIp(@Param("ip") String ip,@Param("id")  String id);

    int modifyAdmin(@Param("id") Long id, @Param("newpasswd") String newpasswd);

    List<IpColor> searchColor(@Param("ip") String ip);

    List<Departname> searchColorDepart(@Param("ip") String ip);

    Ip showIp(@Param("ip") String ip);

    int editIp(@Param("ipconfig") Ipconfig ipconfig);

}

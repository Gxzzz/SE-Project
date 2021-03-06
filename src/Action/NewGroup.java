package Action;

import java.util.UUID;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;
import net.sf.json.JSONObject;
import Data.GroupRepository;
import Data.GroupUserRepository;
import Class.Group;

public class NewGroup extends ActionSupport{
    /**
     * 
     */
    private static final long serialVersionUID = 6675793500838584317L;
    private HttpServletRequest request;
    private String result;

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String execute() {
        try {
//            System.out.println("NewGroup.java: hello bug");
            request = ServletActionContext.getRequest();
            String groupname = URLDecoder.decode(request.getParameter("groupname"), "UTF-8");
            String destprovince = URLDecoder.decode(request.getParameter("destprovince"), "UTF-8");
            String destcity = URLDecoder.decode(request.getParameter("destcity"), "UTF-8");
            String departureprovince = URLDecoder.decode(request.getParameter("departureprovince"), "UTF-8");
            String departurecity = URLDecoder.decode(request.getParameter("departurecity"), "UTF-8");
            String begindate = request.getParameter("begindate");
            int maxmembercount = Integer.parseInt(request.getParameter("maxmembercount"));

//            System.out.println("NewGroup.java: groupname = " + groupname);
//            System.out.println("NewGroup.java: destination = " + destination);
//            System.out.println("NewGroup.java: beginDate = " + begindate);
//            System.out.println("NewGroup.java: maxmembercount = " + maxmembercount);


            String groupid = UUID.randomUUID().toString().replaceAll("-", "");
            Map<String, Object> session1 = ActionContext.getContext().getSession();
            String manager = (String) session1.get("username");
            java.util.Date now = new java.util.Date();
            long aspecialtime = Long.parseLong("15103051387");
            long timestamp = now.getTime() / 100 - aspecialtime;
            int membercount = 1;

            Group group = new Group();
            group.setGroupname(groupname);
            group.setDestprovince(destprovince);
            group.setDestcity(destcity);
            group.setBegindate(begindate);
            group.setMaxmembercount(maxmembercount);
            group.setGroupid(groupid);
            group.setMembercount(membercount);
            group.setManager(manager);
            group.setTimestamp(timestamp);
            group.setDepartureprovince(departureprovince);
            group.setDeparturecity(departurecity);

            GroupRepository grouprepository = new GroupRepository();
            grouprepository.addGroup(group);
            grouprepository.close();
            GroupUserRepository groupuserepository = new GroupUserRepository();
            groupuserepository.addGroupUser(groupid, manager);
            groupuserepository.close();

            Map<String, Object> map = new HashMap<String, Object>();
            map.put("success", "true");

            JSONObject json = JSONObject.fromObject(map);
            result = json.toString();
//             System.out.println("NewGroup.java result = " + result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "success";
    }
}
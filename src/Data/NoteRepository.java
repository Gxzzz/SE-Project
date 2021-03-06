package Data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.opensymphony.xwork2.ActionContext;

import Class.Note;

public class NoteRepository {
	Connection con = null;
    Statement stat = null;
    ResultSet rs = null;
    
    public NoteRepository() throws ClassNotFoundException, SQLException {
        String driver = "com.mysql.jdbc.Driver";
        String username = "jx2k3j2zl4";
        String password = "iz3l1315y14mj00z32whz05hi4z5ymk12ixx12zj";
        String dbUrl = String.format("jdbc:mysql://%s:%s/%s?useUnicode=true&characterEncoding=utf8",
                new Object[] { "w.rdc.sae.sina.com.cn", "3306", "app_lvba" });

        Class.forName(driver);
        this.con = DriverManager.getConnection(dbUrl, username, password);
        this.stat = this.con.createStatement();
    }
    
    public void close() throws SQLException {
        if (this.con != null) {
            this.con.close();
        }
    }
    
    public boolean addNote(Note note){
    	String noteID=note.getNoteID();
    	String noteTitle=note.getNoteTitle();
    	String travelNote=note.getTravelNote();
    	String ownerName=note.getOwnerName();
    	String noteTime=note.getNoteTime();
    	String sql="insert into note(noteID,noteTitle,travelNote,ownerName,noteTime)values('"+noteID+"','"+noteTitle+"','"+travelNote+"','"+ownerName+"','"+noteTime+"')";
		try {
			stat.execute(sql);
			return true;
		} catch (SQLException e) {
			return false;
		}
	}
    public boolean showAll() throws SQLException {
    	String sql="select * from note";
    	rs=stat.executeQuery(sql);
    	ArrayList<Note> noteList=new ArrayList<Note>();
    	while (rs.next()) {
			Note n = new Note();
			n.setNoteID(rs.getString(1));
			n.setNoteTitle(rs.getString(2));
			n.setTravelNote(rs.getString(3));
			n.setOwnerName(rs.getString(4));
			n.setNoteTime(rs.getString(5));
			noteList.add(n);
		}
    	ActionContext.getContext().put("noteList", noteList);
    	return true;
    }
    public boolean oneNoteInfo(String noteID) throws SQLException {
		String sql="select * from note where noteID='"+noteID+"'";
		rs=stat.executeQuery(sql);
		if (rs.next()) {
			Note note=new Note();
			note.setNoteID(rs.getString(1));
			note.setNoteTitle(rs.getString(2));
			note.setTravelNote(rs.getString(3));
			note.setOwnerName(rs.getString(4));
			note.setNoteTime(rs.getString(5));
			ActionContext.getContext().put("aNote", note);
		}
		return true;
	}
    public void deleteNote(String noteID) throws SQLException {
		String sql="delete from note where noteID='" + noteID + "'";
		PreparedStatement pst=con.prepareStatement(sql);
		pst.executeUpdate();
    }
	public ArrayList<Note> myNotes(String username) throws Exception {
    	ArrayList<Note> allmynotes = new ArrayList<Note>();
    	String SearchString = String.format("SELECT * from note WHERE ownerName = \"%s\";", username);
    	rs=stat.executeQuery(SearchString);
    	int mark;
    	while(rs.next()) {
    		allmynotes.add(new Note());
    		mark=allmynotes.size()-1;
    		allmynotes.get(mark).setNoteID(rs.getString("noteID"));
    		allmynotes.get(mark).setNoteTitle(rs.getString("noteTitle"));
    		allmynotes.get(mark).setTravelNote(rs.getString("travelNote"));
    		allmynotes.get(mark).setOwnerName(rs.getString("ownerName"));
    		allmynotes.get(mark).setNoteTime(rs.getString("noteTime"));
    	}
    	close();
    	return allmynotes;
    }
}


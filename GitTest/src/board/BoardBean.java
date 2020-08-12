package board;

import java.sql.Timestamp;




public class BoardBean {
	private int num;
	private String name;
	private String pass;
	private Timestamp Date;
	private int readcount;
	private String content;
	private String subject;
	private String file;
	private int rep_ref;
	private int rep_lev;
	private int rep_seq;
	private int news;
	
	public enum board_Type{
		board_Type_notice,
		board_Type_gallery
	}
	
	private board_Type board_type;
	
	
	public board_Type getBoard_type() {
		return board_type;
	}
	public void setBoard_type(board_Type board_type) {
		this.board_type = board_type;
	}
	public int getNews() {
		return news;
	}
	public void setNews(int news) {
		this.news = news;
	}
	public String getFile() {
		return file;
	}
	public int getRep_ref() {
		return rep_ref;
	}
	public void setRep_ref(int rep_ref) {
		this.rep_ref = rep_ref;
	}
	public int getRep_lev() {
		return rep_lev;
	}
	public void setRep_lev(int rep_lev) {
		this.rep_lev = rep_lev;
	}
	public int getRep_seq() {
		return rep_seq;
	}
	public void setRep_seq(int rep_seq) {
		this.rep_seq = rep_seq;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public Timestamp getDate() {
		return Date;
	}
	public void setDate(Timestamp Date) {
		this.Date = Date;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	
	
	
}

package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import jsp.util.DBConnection;

public class GalleryDAO {
	// insertGallery(자바빈주소)

	public void insertGallery(BoardBean bb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// 예외발생 할 명령
			// 1단계 드라이버 불러오기
			con = DBConnection.getConnection();
			// 3단계 sql
			String sql = "select max(num) as mNum from gallery";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int boardNum = 1;

			if (rs.next()) {
				boardNum = rs.getInt("mNum") + 1;
			}

			sql = "insert into Gallery(num,pass,name,date,readcount,content,subject,file,rep_ref,rep_lev,rep_seq,news) values(?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardNum);
			pstmt.setString(2, bb.getPass());
			pstmt.setString(3, bb.getName());
			pstmt.setTimestamp(4, bb.getDate());
			pstmt.setInt(5, bb.getReadcount());
			pstmt.setString(6, bb.getContent());
			pstmt.setString(7, bb.getSubject());
			pstmt.setString(8, bb.getFile());
			if (bb.getRep_seq() == 0) {
				pstmt.setInt(9, boardNum);
			}else {
				pstmt.setInt(9, bb.getRep_ref());
			}
			pstmt.setInt(10, bb.getRep_lev());
			pstmt.setInt(11, bb.getRep_seq());
			pstmt.setInt(12, 0);

			// 4단계 실행
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}// insertGallery()

	// getGallery(id)
	public BoardBean getGallery(int num) {
		BoardBean bb = new BoardBean();
		bb.setNum(0);

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// 예외발생 할 명령
			// 1단계 드라이버 불러오기
			con = DBConnection.getConnection();
			// sql select id에 해당하는 회원정보 가져오기
			// 3단계 연결정보를 이용해서 sql구문 만들고 실행할 객체생성 => PreparedStatement
			String sql = "select * from Gallery where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 4단계 실행 결과 => ResultSet rs
			rs = pstmt.executeQuery();
			// if rs에 처음위치에서 다음행으로 이동 데이터가 있으면 True
			// 출력 아이디 : 비밀번호 : 이름 : 가입날짜:
			if (rs.next()) {
				bb.setNum(rs.getInt("num"));
				bb.setPass(rs.getString("pass"));
				bb.setName(rs.getString("name"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setContent(rs.getString("Content"));
				bb.setSubject(rs.getString("subject"));
				bb.setFile(rs.getString("file"));
				bb.setRep_lev(rs.getInt("rep_lev"));
				bb.setRep_ref(rs.getInt("rep_ref"));
				bb.setRep_seq(rs.getInt("rep_seq"));
			}
//			 	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 마무리
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		return bb;
	}

	// userCheck(id,pass)
	public int userCheck(int num, String pass) {
		// 신호값 정하기 1 : 아이디 비밀번호 일치, 0 : 비밀번호 틀림, -1 : 아이디없음
		int check = -1;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// 예외발생 할 명령
			// 1단계 드라이버 불러오기
			con = DBConnection.getConnection();
			// 3단계 연결정보를 이용해서 sql구문 만들고 실행할 객체생성 => PreparedStatement
			String sql = "select * from Gallery where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 4단계 실행 결과 => ResultSet rs
			rs = pstmt.executeQuery();
			// 5단계 rs에 저장된 데이터 있는 확인 .next() 다음행으로 이동 데이터 있으면 True
//			                         // 아이디 있음
//			                         없으면 False
//			                         // 아이디 없음
			if (rs.next()) {
//				out.println("아이디있음");
				// if 폼에서 가져온 비밀번호 디비에서 가져온 비밀번호 비교 .equals()
				// 맞으면 "비밀번호 맞음" 틀리면 "비밀번호 틀림"
				if (pass.equals(rs.getString("pass"))) {
//					out.println("비밀번호 맞음");
					check = 1;
					// 폼아이디,비밀번호 디비에저장된 아이디 비밀번호 일치하면 =>
					// 로그인 인증 => 모든 페이지 상관없이 값이 유지되는 세션값 생성
					// 세션값 생성 "id",id
//			 		session.setAttribute("id", id);
//			 		// main.jsp 이동
//			 		response.sendRedirect("main.jsp");

				} else {
//					out.println("비밀번호 틀림");
					check = 0;
				}
			} else {
//				out.println("아이디없음");
				check = -1;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 마무리
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return check;
	}

	// updateGallery(bb)
	public int updateGallery(BoardBean bb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check = 0;
		// check 1 -> 성공 0 -> 실패
		try {
			// 예외발생 할 명령
			// 1단계 드라이버 불러오기
			con = DBConnection.getConnection();
			String sql = "select * from Gallery where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());

			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (!bb.getPass().equals(rs.getString("pass"))) {
					check = 0;
					return check;
				}
			}

			check = 1;

			sql = "update Gallery set name=?, content=?, subject=?, readcount=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bb.getName());
			pstmt.setString(2, bb.getContent());
			pstmt.setString(3, bb.getSubject());
			pstmt.setInt(4, bb.getReadcount());
			pstmt.setInt(5, bb.getNum());
			// 4단계 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 마무리

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return check;
	}
	
	public int updateGallery(int num, int news) {
		// 업데이트가 있을 경우 호출 -> 뉴스 업데이트
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check = 0;
		// check 1 -> 성공 0 -> 실패
		try {
			// 예외발생 할 명령
			// 1단계 드라이버 불러오기
			con = DBConnection.getConnection();
			String sql = "update Gallery set news=? where num=?;";
			check = 1;
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, news);
			pstmt.setInt(2, num);
			// 4단계 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 마무리

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return check;
	}
	
	public int deleteGallery(BoardBean bb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check = 0;
		// check 1 -> 성공
		//       0 -> 실패
		try {
			// 예외발생 할 명령
			// 1단계 드라이버 불러오기
			con = DBConnection.getConnection();
			String sql = "select * from Gallery where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());

			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (!bb.getPass().equals(rs.getString("pass"))) {
					check = 0;
					return check;
				}
			}

			check = 1;

			sql = "delete from Gallery where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());
			// 4단계 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 마무리

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return check;
	}
	
	public int deleteComment(BoardBean bb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int check = 0;
		// check 1 -> 성공
		//       0 -> 실패
		try {
			// 예외발생 할 명령
			// 1단계 드라이버 불러오기
			con = DBConnection.getConnection();
			String sql = "delete from gallerycomment where num=? and ref=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());
			pstmt.setInt(2, bb.getRep_ref());

			// 4단계 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 마무리


			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return check;
	}


	public List getGalleryList() {

		List<BoardBean> GalleryList = new ArrayList<BoardBean>();
//			select * from Gallery where id='kim';
		// id | pass | name | reg_date
		// kim | 1111 | 김길동 | 2020-06-11 15:36:44
		// BoardBean 안에 id | pass | name | reg_date 저장해서 리턴
//			bb.setId(디비에서 가져온 id);
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// 예외발생 할 명령
			// 1단계 드라이버 불러오기
			con = DBConnection.getConnection();
			// 3단계 연결정보를 이용해서 sql구문 만들고 실행할 객체생성 => PreparedStatement
			String sql = "select * from Gallery order by num desc";
			pstmt = con.prepareStatement(sql);
			// 4단계 실행 결과 => ResultSet rs
			rs = pstmt.executeQuery();
			// if rs에 처음위치에서 다음행으로 이동 데이터가 있으면 True
			// 출력 아이디 : 비밀번호 : 이름 : 가입날짜:
			while (rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setNum(rs.getInt("Num"));
				bb.setPass(rs.getString("pass"));
				bb.setName(rs.getString("name"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setContent(rs.getString("content"));
				bb.setSubject(rs.getString("subject"));
				bb.setFile(rs.getString("file"));
				bb.setNews(rs.getInt("news"));
				GalleryList.add(bb);
			}
//				 	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 마무리
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		return GalleryList;
	}

	public int getGalleryCount() {
		int count = 0;

		count = getGalleryList().size();

		return count;
	}

	public List<BoardBean> getGalleryList(int StartRow, int pageSize) {

		List<BoardBean> GalleryList = new ArrayList<BoardBean>();
//		select * from Gallery where id='kim';
		// id | pass | name | reg_date
		// kim | 1111 | 김길동 | 2020-06-11 15:36:44
		// BoardBean 안에 id | pass | name | reg_date 저장해서 리턴
//		bb.setId(디비에서 가져온 id);
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// 예외발생 할 명령
			// 1단계 드라이버 불러오기
			con = DBConnection.getConnection();
			// 3단계 연결정보를 이용해서 sql구문 만들고 실행할 객체생성 => PreparedStatement
			String sql = "select * from Gallery order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, StartRow - 1);
			pstmt.setInt(2, pageSize);
			// 4단계 실행 결과 => ResultSet rs
			rs = pstmt.executeQuery();
			// if rs에 처음위치에서 다음행으로 이동 데이터가 있으면 True
			// 출력 아이디 : 비밀번호 : 이름 : 가입날짜:
			while (rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setNum(rs.getInt("Num"));
				bb.setPass(rs.getString("pass"));
				bb.setName(rs.getString("name"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setContent(rs.getString("content"));
				bb.setSubject(rs.getString("subject"));
				bb.setFile(rs.getString("file"));
				bb.setNews(rs.getInt("news"));
				GalleryList.add(bb);
			}
//			 	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 마무리
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		return GalleryList;
	}

	public List<BoardBean> getGalleryList(HashMap<String, Object> listOpt) {

		List<BoardBean> GalleryList = new ArrayList<BoardBean>();
//		select * from Gallery where id='kim';
		// id | pass | name | reg_date
		// kim | 1111 | 김길동 | 2020-06-11 15:36:44
		// BoardBean 안에 id | pass | name | reg_date 저장해서 리턴
//		bb.setId(디비에서 가져온 id);

		String opt = (String) listOpt.get("opt");
		// 검색 옵션 (제목, 내용, 글쓴이 등등)

		String condition = (String) listOpt.get("condition");
		// 검색 내용

		int startRow = (Integer) listOpt.get("startRow");
		int pageSize = (Integer) listOpt.get("pageSize");
		// 현재 페이지번호

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			StringBuffer sql = new StringBuffer();
			// 예외발생 할 명령
			// 1단계 드라이버 불러오기
			con = DBConnection.getConnection();

			if (opt == null) {

				// 3단계 연결정보를 이용해서 sql구문 만들고 실행할 객체생성 => PreparedStatement
				sql.append("select * from gallery order by rep_ref desc, rep_seq asc limit ?,?");
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setInt(1, startRow - 1);
				pstmt.setInt(2, pageSize);

				sql.delete(0, sql.toString().length());
				// 4단계 실행 결과 => ResultSet rs

			} else if (opt.equals("0")) { // 제목으로 검색
				sql.append("select * from Gallery where subject like ? order by num desc limit ?,?");
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, "%"+condition+"%");
				pstmt.setInt(2, startRow - 1);
				pstmt.setInt(3, pageSize);

				sql.delete(0, sql.toString().length());

			} else if (opt.equals("1")) { // 내용으로 검색
				sql.append("select * from Gallery where content like ? order by num desc limit ?,?");
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, "%"+condition+"%");
				pstmt.setInt(2, startRow - 1);
				pstmt.setInt(3, pageSize);

				sql.delete(0, sql.toString().length());

			} else if (opt.equals("2")) { // 글쓴이으로 검색
				sql.append("select * from Gallery where name like ? order by num desc limit ?,?");
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, "%"+condition+"%");
				pstmt.setInt(2, startRow - 1);
				pstmt.setInt(3, pageSize);

				sql.delete(0, sql.toString().length());

			}

			// if rs에 처음위치에서 다음행으로 이동 데이터가 있으면 True
			// 출력 아이디 : 비밀번호 : 이름 : 가입날짜:
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setNum(rs.getInt("Num"));
				bb.setPass(rs.getString("pass"));
				bb.setName(rs.getString("name"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setContent(rs.getString("content"));
				bb.setSubject(rs.getString("subject"));
				bb.setFile(rs.getString("file"));
				bb.setRep_lev(rs.getInt("rep_lev"));
				bb.setRep_seq(rs.getInt("rep_seq"));
				bb.setRep_ref(rs.getInt("rep_ref"));
				bb.setNews(rs.getInt("news"));
				GalleryList.add(bb);
			}
//			 	
		} catch (

		Exception e) {
			e.printStackTrace();
		} finally {
			// 마무리
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		return GalleryList;
	}
	
	public int updateRep_seq(BoardBean bb) {
		int result = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			// 예외발생 할 명령
			// 1단계 드라이버 불러오기
			con = DBConnection.getConnection();
			String sql = "update Gallery set rep_seq = rep_seq + 1 where rep_ref = ? and rep_seq > ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getRep_ref());
			pstmt.setInt(2, bb.getRep_seq());
			// 4단계 실행
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 마무리

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		return result;
	}
	
	public void insertComment(BoardBean bb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// 예외발생 할 명령
			// 1단계 드라이버 불러오기
			con = DBConnection.getConnection();
			// 3단계 sql
			String sql = "select max(num) as mNum from gallerycomment where ref = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getRep_ref());
			rs = pstmt.executeQuery();
			int boardNum = 1;

			if (rs.next()) {
				boardNum = rs.getInt("mNum") + 1;
			}

			sql = "insert into gallerycomment(ref,num,name,content,news,date) values(?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getRep_ref());
			pstmt.setInt(2, boardNum);
			pstmt.setString(3, bb.getName());
			pstmt.setString(4, bb.getContent());
			pstmt.setInt(5, 1);
			// 4단계 실행
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}// insertComment()
	
	public ArrayList getCommentList(int ContentNum) {

		ArrayList<BoardBean> CommentList = new ArrayList<BoardBean>();
//			select * from Gallery where id='kim';
		// id | pass | name | reg_date
		// kim | 1111 | 김길동 | 2020-06-11 15:36:44
		// BoardBean 안에 id | pass | name | reg_date 저장해서 리턴
//			bb.setId(디비에서 가져온 id);
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// 예외발생 할 명령
			// 1단계 드라이버 불러오기
			con = DBConnection.getConnection();
			// 3단계 연결정보를 이용해서 sql구문 만들고 실행할 객체생성 => PreparedStatement
			String sql = "select * from gallerycomment where ref = ? order by num desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ContentNum);
			// 4단계 실행 결과 => ResultSet rs
			rs = pstmt.executeQuery();
			// if rs에 처음위치에서 다음행으로 이동 데이터가 있으면 True
			// 출력 아이디 : 비밀번호 : 이름 : 가입날짜:
			while (rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setRep_ref(rs.getInt("ref"));
				bb.setNum(rs.getInt("Num"));
				bb.setName(rs.getString("name"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setContent(rs.getString("content"));
				bb.setNews(rs.getInt("news"));
				CommentList.add(bb);
			}
//				 	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 마무리
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		return CommentList;
	}
	
	public ArrayList getNewCommentList(int ContentNum) {

		ArrayList<BoardBean> CommentList = new ArrayList<BoardBean>();
//			select * from Gallery where id='kim';
		// id | pass | name | reg_date
		// kim | 1111 | 김길동 | 2020-06-11 15:36:44
		// BoardBean 안에 id | pass | name | reg_date 저장해서 리턴
//			bb.setId(디비에서 가져온 id);
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// 예외발생 할 명령
			// 1단계 드라이버 불러오기
			con = DBConnection.getConnection();
			// 3단계 연결정보를 이용해서 sql구문 만들고 실행할 객체생성 => PreparedStatement
			String sql = "select * from gallerycomment where ref = ? AND news = 1 order by num desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ContentNum);
			// 4단계 실행 결과 => ResultSet rs
			rs = pstmt.executeQuery();
			// if rs에 처음위치에서 다음행으로 이동 데이터가 있으면 True
			// 출력 아이디 : 비밀번호 : 이름 : 가입날짜:
			while (rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setRep_ref(rs.getInt("ref"));
				bb.setNum(rs.getInt("Num"));
				bb.setName(rs.getString("name"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setContent(rs.getString("content"));
				bb.setNews(rs.getInt("news"));
				CommentList.add(bb);
			}
//				 	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 마무리
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		return CommentList;
	}
	
	public int updateNewComment(BoardBean cb) {
		// 업데이트가 있을 경우 호출 -> 뉴스 업데이트
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				int check = 0;
				// check 1 -> 성공 0 -> 실패
				try {
					// 예외발생 할 명령
					// 1단계 드라이버 불러오기
					con = DBConnection.getConnection();
					String sql = "update gallerycomment set news=0 where num=? AND ref = ?";
					check = 1;
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, cb.getNum());
					pstmt.setInt(2, cb.getRep_ref());
					// 4단계 실행
					pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					// 마무리

					if (rs != null) {
						try {
							rs.close();
						} catch (SQLException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}

					if (pstmt != null) {
						try {
							pstmt.close();
						} catch (SQLException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}

					if (con != null) {
						try {
							con.close();
						} catch (SQLException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}
				return check;
	}
	
	public ArrayList getNewComment(String id) {
		
		ArrayList<BoardBean> CommentList = new ArrayList<BoardBean>();
//		select * from Gallery where id='kim';
	// id | pass | name | reg_date
	// kim | 1111 | 김길동 | 2020-06-11 15:36:44
	// BoardBean 안에 id | pass | name | reg_date 저장해서 리턴
//		bb.setId(디비에서 가져온 id);
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try {
		// 예외발생 할 명령
		// 1단계 드라이버 불러오기
		con = DBConnection.getConnection();
		// 3단계 연결정보를 이용해서 sql구문 만들고 실행할 객체생성 => PreparedStatement
		String sql = "select * from gallery where name = ? AND news = 1";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		// 4단계 실행 결과 => ResultSet rs
		rs = pstmt.executeQuery();
		// if rs에 처음위치에서 다음행으로 이동 데이터가 있으면 True
		// 출력 아이디 : 비밀번호 : 이름 : 가입날짜:
		while (rs.next()) {
			ArrayList<BoardBean> newlist = getNewCommentList(rs.getInt("Num"));
			for(int i = 0; i < newlist.size(); i++) {
				BoardBean bb = newlist.get(i);
				CommentList.add(bb);
			}
		}
//			 	
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		// 마무리
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	return CommentList;
		
	}
	

}// 클래스

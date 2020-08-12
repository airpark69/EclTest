package game;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jsp.util.DBConnection;

public class gameDAO {
	private static gameDAO instance = new gameDAO();
	
	private gameDAO() {}
	
	public static gameDAO getInstance() {
		return instance;
	}
	
	
	public void insertScore(gameBean gb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			// 예외발생 할 명령
			// 1단계 드라이버 불러오기
			con = DBConnection.getConnection();
			// 3단계 sql
			String sql = "insert into game(id, score) value(?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, gb.getId());
			pstmt.setInt(2, gb.getScore());
			
			// 4단계 실행
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

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
	}// insert
	
	public int getScore(String id) {
		// 해당 아이디 스코어 최댓값 보냄.
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int score = 0;
		try {
			// 예외발생 할 명령
			// 1단계 드라이버 불러오기
			con = DBConnection.getConnection();
			// sql select id에 해당하는 회원정보 가져오기
			// 3단계 연결정보를 이용해서 sql구문 만들고 실행할 객체생성 => PreparedStatement
			String sql = "select * from game where id=? order by num desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 4단계 실행 결과 => ResultSet rs
			rs = pstmt.executeQuery();
			// if rs에 처음위치에서 다음행으로 이동 데이터가 있으면 True
			// 출력 아이디 : 비밀번호 : 이름 : 가입날짜:
			if (rs.next()) {
				score = rs.getInt("score");
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

		return score;
	}
	

}

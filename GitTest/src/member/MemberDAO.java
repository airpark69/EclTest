package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jsp.util.DBConnection;

public class MemberDAO {
	// insertMember(자바빈주소)
	

	public void insertMember(MemberBean mb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			// 예외발생 할 명령
			// 1단계 드라이버 불러오기
		    con = DBConnection.getConnection();
			// 3단계 sql
			String sql = "insert into member(id,pass,name,reg_date,email,phone,mobile,gender,postcodeAddress, roadAddress, jibunAddress,"
					+ "detailAddress, extraAddress) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPass());
			pstmt.setString(3, mb.getName());
			pstmt.setTimestamp(4, mb.getReg_date());
			pstmt.setString(5, mb.getEmail());
			pstmt.setString(6, mb.getPhone());
			pstmt.setString(7, mb.getMobile());
			pstmt.setString(8, mb.getGender());
			pstmt.setString(9, mb.getPostcodeAddress());
			pstmt.setString(10, mb.getRoadAddress());
			pstmt.setString(11, mb.getJibunAddress());
			pstmt.setString(12, mb.getDetailAddress());
			pstmt.setString(13, mb.getExtraAddress());
			
			
			// 4단계 실행
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null){try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}}
			
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}// insertMember()

	// getMember(id)
	public MemberBean getMember(String id) {
		MemberBean mb = new MemberBean();
		mb.setId("null");
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// 예외발생 할 명령
			// 1단계 드라이버 불러오기
		    con = DBConnection.getConnection();
			// sql select id에 해당하는 회원정보 가져오기
			// 3단계 연결정보를 이용해서 sql구문 만들고 실행할 객체생성 => PreparedStatement
			String sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 4단계 실행 결과 => ResultSet rs
			rs = pstmt.executeQuery();
			// if rs에 처음위치에서 다음행으로 이동 데이터가 있으면 True
			// 출력 아이디 : 비밀번호 : 이름 : 가입날짜:
			if (rs.next()) {
				mb.setId(rs.getString("id"));
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));
				mb.setReg_date(rs.getTimestamp("reg_date"));
				mb.setEmail(rs.getString("email"));
				mb.setMobile(rs.getString("mobile"));
				mb.setPhone(rs.getString("phone"));
				mb.setPostcodeAddress(rs.getString("postcodeAddress"));
				mb.setRoadAddress(rs.getString("roadAddress"));
				mb.setJibunAddress(rs.getString("jibunAddress"));
				mb.setDetailAddress(rs.getString("detailAddress"));
				mb.setExtraAddress(rs.getString("extraAddress"));
			}
//			 	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 마무리
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if(pstmt != null){try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}}
			
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		return mb;
	}

	// userCheck(id,pass)
	public int userCheck(String id, String pass) {
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
			String sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
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
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if(pstmt != null){try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}}
			
			if(con != null) {
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

	// updateMember(mb)
	public int updateMember(MemberBean mb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check = 0;
		// check 1 -> 성공 0 -> 실패
		try {
			// 예외발생 할 명령
			// 1단계 드라이버 불러오기
		    con = DBConnection.getConnection();
			String sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(!mb.getPass().equals(rs.getString("pass"))) {
					check = 0;
					return check;
				}
			}
			
			check = 1;
			
			sql = "update member set name=?, email=?, phone=?, mobile=?, postcodeAddress=?,"
					+ "roadAddress=?, jibunAddress=?, detailAddress=?, extraAddress=? where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getName());
			pstmt.setString(2, mb.getEmail());
			pstmt.setString(3, mb.getPhone());
			pstmt.setString(4, mb.getMobile());
			pstmt.setString(5, mb.getPostcodeAddress());
			pstmt.setString(6, mb.getRoadAddress());
			pstmt.setString(7, mb.getJibunAddress());
			pstmt.setString(8, mb.getDetailAddress());
			pstmt.setString(9, mb.getExtraAddress());
			pstmt.setString(10, mb.getId());
			// 4단계 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 마무리
		
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if(pstmt != null){try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}}
			
			if(con != null) {
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

	public List getMemberList() {

		List<MemberBean> memberList = new ArrayList<MemberBean>();
//			select * from member where id='kim';
		// id | pass | name | reg_date
		// kim | 1111 | 김길동 | 2020-06-11 15:36:44
		// MemberBean 안에 id | pass | name | reg_date 저장해서 리턴
//			mb.setId(디비에서 가져온 id);
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// 예외발생 할 명령
			// 1단계 드라이버 불러오기
		    con = DBConnection.getConnection();
			// 3단계 연결정보를 이용해서 sql구문 만들고 실행할 객체생성 => PreparedStatement
			String sql = "select * from member";
			pstmt = con.prepareStatement(sql);
			// 4단계 실행 결과 => ResultSet rs
			rs = pstmt.executeQuery();
			// if rs에 처음위치에서 다음행으로 이동 데이터가 있으면 True
			// 출력 아이디 : 비밀번호 : 이름 : 가입날짜:
			while (rs.next()) {
				MemberBean mb = new MemberBean();
				mb.setId(rs.getString("id"));
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));
				mb.setReg_date(rs.getTimestamp("reg_date"));
				memberList.add(mb);
			}
//				 	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 마무리
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if(pstmt != null){try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}}
			
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		return memberList;
	}
	
	public int deleteMember(String id, String pass) {
		int check = userCheck(id, pass);
		
		if (check != 1) {
			check = 0;
			return check;
		}
		else {
			Connection con = null;
			PreparedStatement pstmt = null;
			try {
				// 예외발생 할 명령
				// 1단계 드라이버 불러오기
			    con = DBConnection.getConnection();
				// 3단계 sql
				String sql = "delete from member where id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				
				// 4단계 실행
				pstmt.executeUpdate();

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(pstmt != null){try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}}
				
				if(con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		}
		
		return check;
	}

}// 클래스

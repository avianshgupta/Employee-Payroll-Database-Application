package ex10;
import java.sql.*;
/**
 *
 * @author AVIANSH GUPTA
 */
public class Ex10 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        try{
            Class.forName("oracle.jdbc.driver.OracleDriver"); 
            Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","scott","a1028");
            Statement stmt=con.createStatement();  
  
            //step4 execute query  
            //ResultSet rs=stmt.executeQuery("execute searchEmp('E001')");
            //System.out.println(rs);
            CallableStatement cstmt = null;
            String SQL = "{call searchEmp('E001')}";
            cstmt = con.prepareCall (SQL);
            cstmt.execute(SQL);
            
            //while(rs.next())  
              //  System.out.println(rs.getString(1)+"  "+rs.getString(2)+"  "+rs.getString(3));  
  
            //step5 close the connection object  
            con.close();
        }
        catch(Exception e){
            System.out.println("Exception");
        }
    }
    
}

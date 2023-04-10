package com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

import com.dbhelper.DBHelper;

public class BidSystem {
	public void AutoBid() {
		int currentMaxBid = 0;
		DBHelper dao = new DBHelper();
		Connection connection = dao.getConnection();
		
		try {
			PreparedStatement ps1=connection.prepareStatement("select max(upperLimit) as maxUpperLimit from bidding");
//			ps1.setString(1,productName);
//			ps1.setString(2,username);
//			ps1.setString(3, category);
			
			ResultSet rs = ps1.executeQuery();
			rs.next();
			float maxUpperLimit = rs.getFloat("maxUpperLimit");
			System.out.println(maxUpperLimit);
			
			
			ps1 = connection.prepareStatement("select username from bidding where upperLimit <= ?");
			
			ps1.setFloat(1, maxUpperLimit);
			
			rs = ps1.executeQuery();
			
			rs.last();
			int countRows = rs.getRow();
			rs.first();
			
			if(countRows>1) {
				//Send Email Notifications to all users from rs
			}
			
			
			printResultSet(rs);

		}
		catch(Exception e) {
			
		}

		
		
	}
	public void printResultSet(ResultSet rs) {
		try {
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnsNumber = rsmd.getColumnCount();
			while (rs.next()) {
			    for (int i = 1; i <= columnsNumber; i++) {
			        if (i > 1) System.out.print(",  ");
			        String columnValue = rs.getString(i);
			        System.out.print(rsmd.getColumnName(i) + " -> " + columnValue + " ");
			    }
			    System.out.println("");
			}

		}
		catch(Exception e) {
			
		}
		
	}
	
	public void ManualBid() {
		
	}
	
	public static void main(String[] args) {
		BidSystem bs = new BidSystem();
		bs.AutoBid();
	}
}

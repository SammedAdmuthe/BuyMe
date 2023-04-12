package com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

import com.dbhelper.DBHelper;

import EmailNotification.EmailNotification;

public class BidSystem {
	public void AutoBid() {
		int currentMaxBid = 0;
		DBHelper dao = new DBHelper();
		Connection connection = dao.getConnection();
		System.out.print("Within Auto bid");
		try {
			PreparedStatement ps1=connection.prepareStatement("select max(upperLimit) as maxUpperLimit from bidding");
			
			ResultSet rs1 = ps1.executeQuery();
			rs1.next();
			float maxUpperLimit = rs1.getFloat("maxUpperLimit");
			System.out.println(maxUpperLimit);
			
			
			PreparedStatement ps2 = connection.prepareStatement("SELECT e.emailId FROM bidding b JOIN enduser e ON b.username = e.username WHERE b.upperLimit <= ?");
			ps2.setFloat(1, maxUpperLimit);
			ResultSet rs2 = ps2.executeQuery();

			System.out.print("inside bidding");
				System.out.print("we have result set");
				while(rs2.next()) {
				     String email = rs2.getString("emailId");
				     EmailNotification.sendEmail(email, "Bidding Alert","Someone bid higher than you");
				}
			
		}
		catch(Exception e) {
			System.out.print(e);
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

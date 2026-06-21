package com.japansport.dao;

import java.io.*;
import java.sql.*;
import java.util.Properties;

public class DBConnect {

    private static DBConnect instance;
    private Connection conn;

    private DBConnect() {
    }

    static DBConnect getInstance() {
        if (instance == null) {
            instance = new DBConnect();
        }
        return instance;
    }

    public Statement createStatement() {
        Connection conn = getConnect();
        if (conn == null) {
            return null;
        }
        try {
            return conn.createStatement();
        } catch (SQLException e) {
            return null;
        }
    }

    public Connection getConnect() {
        try {
            if (conn == null || conn.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://" + DBProperties.host() + ":" + DBProperties.port() + "/" + DBProperties.database() + "?useUnicode=true&characterEncoding=utf-8";
                conn = DriverManager.getConnection(url, DBProperties.username(), DBProperties.password());
            }
            return conn;
        } catch (ClassNotFoundException | SQLException e) {
            return null;
        }
    }


    class DBProperties {
        static Properties prop = new Properties();

        static {
            try {
                File f = new File("db.properties");
                System.out.println(f.getAbsolutePath());
                InputStream is = null;
                if (f.exists()) {
                    is = new FileInputStream(f);
                } else {
                    is = DBProperties.class.getClassLoader().getResourceAsStream("db.properties");
                }
                if (is != null) {
                    prop.load(is);
                } else {
                    throw new FileNotFoundException("property file 'db.properties' not found in the classpath");
                }
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        public static String host() {
            return prop.getProperty("db.host");
        }

        public static int port() {
            return Integer.parseInt(prop.getProperty("db.port"));
        }

        public static String username() {
            return prop.getProperty("db.username");
        }

        public static String password() {
            return prop.getProperty("db.password");
        }

        public static String database() {
            return prop.getProperty("db.dbName");
        }
    }

    public static void main(String[] args) {
        Statement statement = DBConnect.getInstance().createStatement();
        try {
            ResultSet rs = statement.executeQuery("SELECT * FROM user_key_history");
            System.out.println("--- KEY HISTORY RECORD LIST ---");
            while (rs.next()) {
                String pk = rs.getString("public_key");
                String pkSub = pk != null && pk.length() > 20 ? pk.substring(0, 20) + "..." + pk.substring(pk.length() - 20) : pk;
                System.out.println("ID: " + rs.getInt("id") + 
                                   " | UserID: " + rs.getInt("user_id") + 
                                   " | PK: " + pkSub + 
                                   " | Created: " + rs.getTimestamp("created_at") + 
                                   " | Expired: " + rs.getTimestamp("expired_at"));
            }
            System.out.println("--- END OF LIST ---");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

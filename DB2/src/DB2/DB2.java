package DB2;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;


public class DB2 {

    private Connection connection;
    private Statement statement;
    private ResultSet resultSet;


    public void openConnection(){


        try {

            DriverManager.registerDriver(new com.ibm.db2.jcc.DB2Driver());

        }

        catch(Exception cnfex) {

            System.out.println("Problem in loading or registering IBM DB2 JDBC driver");

            cnfex.printStackTrace();
        }


        try {

            connection = DriverManager.getConnection("jdbc:db2://62.44.108.24:50000/SAMPLE", "db2admin", "db2admin");

            statement = connection.createStatement();

        }

        catch(SQLException s){

            s.printStackTrace();

        }

    }

    public void closeConnection(){

        try {

            if(null != connection) {

                // cleanup resources, once after processing

                resultSet.close();

                statement.close();


                // and then finally close connection

                connection.close();

            }
        }

        catch (SQLException s) {

            s.printStackTrace();

        }

    }


    public void select(String stmnt, int column) {
        try {
            resultSet = statement.executeQuery(stmnt);
            String result = "";
            boolean foundRecords = false;

            while (resultSet.next()) {
                foundRecords = true;

                for (int i = 1; i <= column; i++) {
                    result += resultSet.getString(i);

                    if (i == column) {
                        result += " \n";
                    } else {
                        result += ", ";
                    }
                }
            }

            if (foundRecords) {
                System.out.println("Executing query: " + stmnt + "\n");
                System.out.println("Result output \n");
                System.out.println("---------------------------------- \n");
                System.out.println(result);
                System.out.println("---------------------------------- \n");
            } else {
                System.out.println("No records found.");
            }
        } catch (SQLException s) {
            s.printStackTrace();
        }
    }

    public void insert(String stmnt) {
        try {
            int numRowsAffected = statement.executeUpdate(stmnt);
            if (numRowsAffected > 0) {
                System.out.println("Successfully inserted!");
            } else {
                System.out.println("Unsuccessfully inserted. Please enter valid data.");
            }
        } catch (SQLException s) {
            System.out.println("Unsuccessfully inserted. Please enter valid data.");
            s.printStackTrace();
        }
    }

    public void delete(String stmnt){
        try {
            int rowsAffected = statement.executeUpdate(stmnt);
            if (rowsAffected > 0) {
                System.out.println("Successfully deleted!");
            } else {
                System.out.println("No found matches with the specified requirement.");
            }
        } catch (SQLException s) {
            System.out.println("Unsuccessfully deleted! Please check your query.");
            s.printStackTrace();
        }
    }

    public static void main(String[] args) throws SQLException {

        DB2 db2Obj = new DB2();
        String stmnt = "";

        db2Obj.openConnection();

        stmnt = "SELECT CLIENTNAME, BUDGET, EMAIL, CLIENTPHONE FROM FN24_0MI0700131.CLIENTS";
        db2Obj.select(stmnt, 4);

        stmnt = "SELECT DEALNO, DATE, FLATNO, AGENCYPERSONALNO, CLIENTSNO FROM FN24_0MI0700131.FLATDEALS";

        db2Obj.select(stmnt, 5);

        Scanner scanner = new Scanner(System.in);


        System.out.println("Enter the client's number: ");
        String ClientNUMBER;
        ClientNUMBER = scanner.nextLine();

        stmnt = "SELECT DEALNO, DATE, FLATNO, AGENCYPERSONALNO, CLIENTSNO FROM FN24_0MI0700131.FLATDEALS + JOIN  where CLIENTSNO = '" + ClientNUMBER + "'";


        stmnt = "SELECT FD.DEALNO, FD.DATE, FD.FLATNO, AP.DESCRIPTION, AP.CITY, AP.NEIGHBOURHOOD, AP.ROOMS, AP.NAMEOFFICE " +
                "FROM FN24_0MI0700131.FLATDEALS FD " +
                "JOIN FN24_0MI0700131.FLATS AP ON FD.FLATNO = AP.FLATNO " +
                "WHERE FD.CLIENTSNO = '" + ClientNUMBER + "'";

        db2Obj.select(stmnt, 8);

        System.out.println("Enter a client number for a new client: ");
        String clientNumber = scanner.nextLine();
        System.out.println("Enter the name of the new client: ");
        String Name = scanner.nextLine();
        System.out.println("Enter the new client's phone number: ");
        String ClientPhone = scanner.nextLine();
        System.out.println("Enter the new client`s maximum budget: ");
        double budget = Double.parseDouble(scanner.nextLine());
        System.out.println("Enter the new client`s email address: ");
        String Email = scanner.nextLine();


        stmnt = " INSERT INTO FN24_0MI0700131.CLIENTS(CLIENTNUM,CLIENTNAME,BUDGET,EMAIL,CLIENTPHONE)"
                + " VALUES ('" + clientNumber + "','" + Name + "','"  + budget + "','" + Email +  "','" + ClientPhone +"')";

        db2Obj.insert(stmnt);


        System.out.println("Enter the number of the client you want to delete: ");
        String clientsnumber = scanner.nextLine();

        stmnt = "DELETE FROM FN24_0MI0700131.CLIENTS WHERE CLIENTNUM = " + "'" + clientsnumber + "' ";

        db2Obj.delete(stmnt);

        db2Obj.closeConnection();

    }
}



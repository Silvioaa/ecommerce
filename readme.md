# E-commerce Application

My name is Silvio Acevedo and I'm a Fullstack Developer. I created this application to show my knowledge and skill in web development. It was created using React, ASP.NET Core and Sql Server.

## Application's URL

The web page is published and can be accessed in [https://ecommerce.silvioacevedo.space](https://ecommerce.silvioacevedo.space).

## Application's Project

This application is a work in progress, you can check the past, current and upcoming tasks in it's [github's project](https://github.com/users/Silvioaa/projects/1/views/1).  

## Installation

To clone this repository, open a bash or cmd terminal and run the following command:

```bash
git clone https://github.com/Silvioaa/ecommerce.git
```

### MySQL

1. Install MySQL. You can use this [MySQL installation guide](https://dev.mysql.com/doc/mysql-installation-excerpt/5.7/en/).
2. - If you are using Windows
       - Open the command prompt
       - Go to MySQL's bin folder \
       ```cd \Program Files\MySQL\MySQL Server [the MySQL Server version number]\bin```
       - Once positioned on that folder, open mysql with the root user. After pressing Enter, type the root user's password. \
       ```mysql -h localhost -u root -p``` 
   - If you are using Linux
       - In the command line, open mysql with the root user using sudo privileges \
       ```sudo mysql -h localhost -u root -p```
       - Type the sudo password first and the mysql root user's password next
3. Run the Dump.sql file in the root folder of this repository \
       ```source [route to Dump.sql file]Dump.sql```
4. Create a MySQL user \
       ```CREATE USER 'someusername'@'localhost' IDENTIFIED BY 'somepassword';```
5. Grant the user execute privilege to run the stored procedures \
       ```GRANT EXECUTE ON PROCEDURE ecom.Select_Products TO 'someusername'@'localhost';``` \
       ```GRANT EXECUTE ON PROCEDURE ecom.Insert_Purchase TO 'someusername'@'localhost';```
6. Exit MySQL \
       ```exit``` 
8. Create a ConnectionString environment variable and assign a connection string with the user you created and it's password. 
   - In Windows: 
       - Type the following command in Windows cmd: \
       ```setx ConnectionString "server=localhost;uid=someusername;pwd=somepassword;database=ecom"``` 
   - In Linux: 
       - In your home directory, open the .bashrc file using vim \
       ```sudo vim .bashrc``` 
       - Press the "i" key, add a new line at the bottom of the file that reads this: \
       ```export ConnectionString="server=localhost;uid=someusername;pwd=somepassword;database=ecom"``` 

### ASP.NET Core

To run the ASP.NET Core application you can open the Ecommerce.sln file with Visual Studio and run the application from there. You can also run it from a cmd or a bash terminal, by accessing the dotnet/Ecommerce folder and running:

```bash
dotnet run
```
If you want to run the application in the background, you can too. The syntax will be different depending of which shell you are using.

In cmd:
```shell
start dotnet run
```

In bash:
```bash
dotnet run &
```

### React

Before running the react application, you first need to [install yarn](https://classic.yarnpkg.com/lang/en/docs/install) in your machine (if it is not installed already). 

In order to run the react application, you first need to open a cmd or bash terminal, access the react folder and run the following command to install all the application's dependencies.

```bash
yarn install
```

After the dependencies are installed, you can run the react application with the following command:

```bash
yarn start
```



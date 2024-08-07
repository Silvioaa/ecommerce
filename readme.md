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
### Sql Server

In order to run this website's database, you can do it either using a Sql Server Docker container and running a script that will create the database and the necessary data, or manually installing Sql Server (if it's not installed in your computer yet) and running said script.

Note: This guide shows the commands to use the Sql Server Express Edition, certain parameters would be different in other versions.

#### With Docker container

1. [Install Docker](https://docs.docker.com/engine/install/) in your machine if it's not installed yet.
2. Create and execute a Sql Server Docker container.

```bash
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=SomeSafePassword5241$" -e "MSSQL_PID=Express" -p 1433:1433 --name sqlserver -d mcr.microsoft.com/mssql/server:2022-latest
```
3. Start the Sql Server Docker Container.
```bash
docker container start sqlserver
```
4. Copy the script.sql file located in the root folder of this repository in the Docker container (the line below will work if, in the shell you are using, you are positioned on the root folder of the repository. This command will place the script.sql file in the root folder of the Docker container).
```bash
docker cp ./script.sql sqlserver:/
```
5. Run the script in the script.sql file located in the root folder of this repository, in the Sql Server Docker container.
```bash
docker exec -it sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P SomeSafePassword5241$ -i /script.sql
```
6. Create a "ConnectionString" environment variable and assign it the connection string to connect with the Sql Server database.

```bash
export ConnectionString = "Server=tcp:172.17.0.1,1433;Initial Catalog=silvioaa_ecom;User ID=datauser;Password=Somereallydifficultpassword1425!;Encrypt=True;TrustServerCertificate=True;"
```
#### Installing (or using) Sql Server directly

1. Install Sql Server (if it's not installed yet).
    
    * [Installation instructions for Windows](https://learn.microsoft.com/en-us/sql/database-engine/install-windows/install-sql-server)
    * [Installation instructions for Linux](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup)
    
2. In the command line, run the script.sql script file using sqlcmd.
```bash
sqlcmd -S localhost -U ["sa" or a different user in the sysadmin role] -P [password] -i [script_file_path]'
```
3. Create a "ConnectionString" environment variable and assign it the connection string to connect with the Sql Server database.

```bash
export ConnectionString = "Server=localhost\SQLEXPRESS;Initial Catalog=silvioaa_ecom;User ID=datauser;Password=Somereallydifficultpassword1425!;Encrypt=True;TrustServerCertificate=True;"
```

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



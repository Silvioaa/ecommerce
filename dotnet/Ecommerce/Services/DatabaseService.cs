using Microsoft.AspNetCore.Mvc.Diagnostics;
using Microsoft.Data.SqlClient;
using MySqlConnector;
using System.ComponentModel;
using System.Data;

namespace Ecommerce.Services
{
    public class DatabaseService
    {
        private MySqlConnection _connection;
        public DatabaseService(MySqlConnection connection) {
            _connection = connection;
        }

        public delegate void ParameterMapper(MySqlParameterCollection paramCol);
        public delegate void MapSingleRecord(IDataReader reader);

        public void SelectData(string procName, ParameterMapper parameterMapper, MapSingleRecord recordMapper)
        {

            try
            {
                using (MySqlCommand command = new MySqlCommand())
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Connection = _connection;
                    command.CommandText = procName;
                    parameterMapper(command.Parameters);
                    _connection.Open();
                    MySqlDataReader reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        recordMapper(reader);
                    }
                    _connection.Close();

                }
            } catch {
                if (_connection.State == ConnectionState.Open)
                {
                    _connection.Close();
                    throw;
                }
            }

        }

        public void HandleData(string procName, ParameterMapper parameterMapper, ParameterMapper returnedParametersMapper)
        {
            try
            {
                using (MySqlCommand command = new MySqlCommand())
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Connection = _connection;
                    command.CommandText = procName;
                    parameterMapper(command.Parameters);
                    _connection.Open();
                    command.ExecuteNonQuery(); 
                    _connection.Close();
                    returnedParametersMapper(command.Parameters);
                }
            }
            catch
            {
                if (_connection.State == ConnectionState.Open)
                {
                    _connection.Close();
                }
                throw;
            }
        }
    }
}

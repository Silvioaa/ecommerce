using Microsoft.AspNetCore.Mvc.Diagnostics;
using Microsoft.Data.SqlClient;
using System.ComponentModel;
using System.Data;

namespace Ecommerce.Services
{
    public class DatabaseService
    {
        private SqlConnection _connection;
        public DatabaseService(SqlConnection connection) {
            _connection = connection;
        }

        public delegate void ParameterMapper(SqlParameterCollection paramCol);
        public delegate void MapSingleRecord(IDataReader reader);

        public void SelectData(string procName, ParameterMapper parameterMapper, MapSingleRecord recordMapper)
        {

            try
            {
                using (SqlCommand command = new SqlCommand())
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Connection = _connection;
                    command.CommandText = procName;
                    parameterMapper(command.Parameters);
                    _connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
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

        public void InsertData(string procName, ParameterMapper parameterMapper, ParameterMapper returnedParametersMapper)
        {
            try
            {
                using (SqlCommand command = new SqlCommand())
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

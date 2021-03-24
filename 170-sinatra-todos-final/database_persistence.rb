require 'pg'

class DatabasePersistence
  def initialize
    @db = PG.connect(dbname: 'todos')
  end

  def find_list(id)
    # session[:lists].find { |list| list[:id] == id }
    sql = <<~SQL
      SELECT * FROM list
      WHERE id = $1
      LIMIT 1
    SQL

    result = db.exec_params(sql, [id])
    tuple = result.first
    todos = retrieve_todos(tuple['id'])
    { id: tuple['id'], name: tuple['name'], todos: todos }
  end

  def retrieve_lists
    sql = <<~SQL
      SELECT id, name FROM list
    SQL
    result = db.exec(sql)
    lists = []
    result.each do |tuple|
      todos = retrieve_todos(tuple['id'])
      lists << { id: tuple['id'], name: tuple['name'], todos: todos }
    end

    lists
  end

  def retrieve_todos(list_id)
    sql = <<~SQL
      SELECT id, name, completed from todo
       WHERE list_id = $1;
    SQL
    result = db.exec_params(sql, [list_id])
    todos = []
    result.each do |tuple|
      completed = tuple['completed'] == 't' ? true : false
      todos << { id: tuple['id'], name: tuple['name'],
                 completed: completed }
    end

    todos
  end

  def push_to_lists(hsh)
    session[:lists] = retrieve_lists << hsh
  end

  def delete(id)
    session[:lists].reject! { |list| list[:id] == id }
  end

  def set_message(message_type, text)
    session[message_type] = text
  end

  private

  attr_accessor :db
end

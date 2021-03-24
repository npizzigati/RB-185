require 'pg'

class DatabasePersistence
  def initialize
    @db = PG.connect(dbname: 'todos')
  end

  def find_list(id)
    session[:lists].find { |list| list[:id] == id }
  end

  def retrieve_lists
    sql = <<~SQL
      SELECT id, name FROM list
    SQL
    result = db.exec(sql)
    lists = []
    result.each do |tuple|
      lists << { id: tuple['id'], name: tuple['name'], todos: [] }
    end

    lists
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

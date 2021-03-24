class SessionPersistence
  attr_accessor :session

  def initialize(session)
    @session = session
  end

  def find_list(id)
    session[:lists].find{ |list| list[:id] == id }
  end

  def retrieve_lists
    session[:lists] || []
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
end

# encoding: UTF-8
module ApplicationHelper

  def get_options list
    options = ""
    list.each do |l|
     options = options + "<option value='#{l.id}' >#{l.name}</option>"  
    end
    return options.html_safe
  end
  
  #￥
  def format_money(money)
  	number_to_currency(money, :unit => "￥", :precision => 0)
  end
  
  
end

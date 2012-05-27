# coding: utf-8
class PagesController < ApplicationController
  def home
    @title = "Главная"
    @items = Item.limit(10).order("created_at desc")
  end

  def about
    @title = "О проекте"
  end

  def contact
    @title = "Контакты"
  end
  
  def auth
    @title = "Вход"
    session[:return_url] = request.referer
  end
  
  def browse
    if params[:id].nil?
      @title = "Каталог"
      @items = Item.limit(20).order("created_at desc")
    else
      @rubric = Rubric.find(params[:id])
      @title = "#{@rubric.name} - Каталог"
      @items = Item.where("rubric_id = ?", params[:id])
    end
  end
  
  def search
    @title = "Поиск"
    if params[:search].length < 2
      @is_shortquery = true
    else
      @items = Item.where(['name like ?', "%#{params[:search]}%"]).paginate(:page => params[:page], :per_page => 10)
    end
  end

end

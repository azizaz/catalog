# coding: utf-8
module ApplicationHelper
  # Return a title on a per-page basis.
  def title
    base_title = "Предприятия Кировограда"
    if @title.nil?
      base_title
    else
      "#{@title} - #{base_title}"
    end
  end
  
  # Return a rubrics.
  def rubrics
    @rubrics = Rubric.all
  end
end

module ApplicationHelper

  def publish_helper(status)
    if status
      "<span class='label label-success'> Publicado</span>".html_safe
    else
      "<span class='label label-default'>Não Publicado</span>".html_safe
    end
  end


  
end

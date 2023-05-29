module ApplicationHelper

  # deviseのflashをBootstrap対応にする
  def bootstrap_class_for(flash_type)
    case flash_type
      when "alert"
        "warning"
      when "notice"
        "success"
      else
        flash_type.to_s
    end
  end

end

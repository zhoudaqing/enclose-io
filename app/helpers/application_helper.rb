module ApplicationHelper
  def file_item(x)
    case x.kind
    when 'exe32'
      '<i class="fa fa-windows" aria-hidden="true"></i>'
    when 'linux64'
      '<i class="fa fa-linux" aria-hidden="true"></i>'
    when 'mac64'
      '<i class="fa fa-apple" aria-hidden="true"></i>'
    end.html_safe + ' ' + x.filename
  end
end

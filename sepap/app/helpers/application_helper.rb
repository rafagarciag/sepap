# -*- encoding : utf-8 -*-
module ApplicationHelper
  def interpretar(texto)
    opciones = [:hard_wrap, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    sintaxis(Redcarpet.new(texto, *opciones).to_html).html_safe
  end
  def sintaxis(html)
    doc = Nokogiri::HTML(html)
    doc.search("//pre[@lang]").each do |pre|
      pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
    end
    doc.to_s
  end
end
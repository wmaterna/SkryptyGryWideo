#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'rubygems'


amazon_url = "https://www.amazon.pl/gp/bestsellers/sports/20859746031?ref_=Oct_d_obs_S&pd_rd_w=ZMPUi&content-id=amzn1.sym.a0ebfd85-fa68-4ed6-a964-13f4f70f9bab&pf_rd_p=a0ebfd85-fa68-4ed6-a964-13f4f70f9bab&pf_rd_r=MPYWAVTBRSP5RHZ8S6W1&pd_rd_wg=lJUAK&pd_rd_r=2111740f-35f7-4220-85b8-b29493d6d889"
productsInfo = []
headers = {"User-Agent" => 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Silk/44.1.54 like Chrome/44.0.2403.63 Safari/537.36'}
html = URI.open(amazon_url, headers)
doc = Nokogiri::HTML(html.read)


class Product
    def initialize(prod, price)
       @prod_prod = prod
       @prod_price = price
    end
    def to_s
        "Product: #{@prod_prod} \nPrice: #{@prod_price} \n\n"
    end
 end



def getLongDesc(detailed_link)
    html = URI.open(detailed_link)
    doc = Nokogiri::HTML(html.read)
    detail_desc = doc.css('div#availability').text.strip
    if detail_desc == nil
        return "No availability info"
    else
        return detail_desc
    end
end

def printProdList(list)
    puts "PRODUCTS LIST"
    list.map{|prod| 
    puts prod
}
end

puts "Crawler Ruby"
info = doc.css('div.zg-grid-general-faceout').each do |container|
    product_description_short = container.css('div._cDEzb_p13n-sc-css-line-clamp-3_g3dy1').text.strip
    product_price = container.css('span._cDEzb_p13n-sc-price_3mJ9Z').text.strip
    if product_description_short != "" && product_price != ""
        prod = Product.new(product_description_short, product_price)
        productsInfo.append(prod)
    else
        "Wrong data format"
    end
printProdList(productsInfo)
end

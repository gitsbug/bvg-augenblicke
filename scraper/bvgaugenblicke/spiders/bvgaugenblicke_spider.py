#    BVG Augenblicke Spider: Download flirt moments from bvg.de/augenblicke
#    Copyright (C) 2013 gitsbug
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
from scrapy.spider import BaseSpider
from scrapy.selector import HtmlXPathSelector
from scrapy.http import Request

from bvgaugenblicke.items import BvgaugenblickeItem

class BvgaugenblickeSpider(BaseSpider):
  name = "bvgaugenblicke"
  allowed_domains = ["bvg.de"]
  start_urls = ["https://www.bvg.de/index.php/de/9460/name/Alle+Augenblicke.html"]

  def parse(self, response):
    hxs = HtmlXPathSelector(response)

    augenblicke = hxs.select('//table[@id="augenblicke_overview"]//tr')

    for augenblick in augenblicke:
      itm = BvgaugenblickeItem()

      linie = augenblick.select('.//td[@class="col_one"]//span/text()').extract()
      if linie and len(linie) == 1:
        itm['linie'] = linie[0]

      zeit = augenblick.select('.//td//span[@class="meta_infos"]//text()').extract()
      if zeit and len(zeit) == 2:
        itm['zeit'] = zeit[0]

      poster = augenblick.select('.//td/span[@class="meta_infos"]//strong//text()').extract()
      if poster and len(poster) == 1:
        itm['poster'] = poster[0]

      titel = augenblick.select('.//td//h3//a//text()').extract()
      if titel and len(titel) == 1:
        itm['titel'] = titel[0].strip()

      link = augenblick.select('.//td//h3//a//@href').extract()
      if link and len(link) == 1:
        itm['link'] = link[0]
        request = Request(link[0], callback=self.parseAugenblickDetail)
        request.meta['item'] = itm
        yield request

      #yield itm

    # Link auf die naechste Seite
    links = hxs.select('//a[@class="next float_left"]//@href').extract()
    if links and len(links) > 0:
      yield Request(links[0], callback=self.parse)

  def parseAugenblickDetail(self, response):
    hxs = HtmlXPathSelector(response) 
    item = response.meta['item']

    verfasst = hxs.select('//div[@id="augenblick_detail"]//div[@class="info_block"]/p/text()').extract()
    if verfasst and len(verfasst) == 3:
      item['verfasst'] = verfasst[1]
      # Bereits erfasste Informationen:
      # [2] = poster
      # [1] = augenblickzeit

    text = hxs.select('//div[@id="augenblick_detail"]/div[@class="richtext"]/p/text()').extract()
    if text and len(text) > 0:
      item['text'] = text 
 
    return item

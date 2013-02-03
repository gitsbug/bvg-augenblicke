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
from scrapy.item import Item, Field

class BvgaugenblickeItem(Item):
  linie = Field()
  zeit = Field()
  poster = Field()
  titel = Field()
  link = Field()
  text = Field()
  verfasst = Field()

  def __str__(self):
    return "%s: %s (%s @ %s)" % (self.get('poster'), self.get('titel'), self.get('zeit'), self.get('linie'))
